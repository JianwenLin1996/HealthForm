import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../globals.dart' as globals;
import '../questionaire_01/questionairepage.dart';
import '../record/database_helper.dart';
import '../record/record.dart';
import './history_detail.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final GlobalKey<ScaffoldState> _historyScaffoldKey =
      new GlobalKey<ScaffoldState>();

  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Record> _recordList;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    if (_recordList == null) {
      _recordList = List<Record>();
      updateListView();
    }
    return Scaffold(
        key: _historyScaffoldKey,
        resizeToAvoidBottomInset: false,
        drawerEnableOpenDragGesture: true,
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.green[700]),
                child: Stack(children: <Widget>[
                  Positioned(
                      left: 15.0,
                      bottom: 10.0,
                      child: new Text("目录",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w500)))
                ])),
            ListTile(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => QuestionairePage())),
              title: Row(children: <Widget>[
                new Icon(Icons.question_answer),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: new Text("问卷"),
                )
              ]),
            ),
            ListTile(
              onTap: () {},
              title: Row(children: <Widget>[
                new Icon(Icons.library_books),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: new Text("存档"),
                )
              ]),
            ),
          ],
        )),
        appBar: new AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => _historyScaffoldKey.currentState.openDrawer()),
          elevation: 15,
          backgroundColor: Colors.greenAccent,
          title: new Text("存档", style: TextStyle(color: Colors.black)),
        ),
        body: new Container(
          child: new ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _count,
              itemBuilder: (BuildContext context, int position) {
                return Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetail(_recordList[position]),));},
                      title: Text(this._recordList[position].name),
                      subtitle: Text(this._recordList[position].date),
                      trailing: GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: () {
                          _delete(context, _recordList[position]);
                        },
                      ),
                    ));
              }),
        ));
  }

  void _delete(BuildContext context, Record record) async {
    int result = await _databaseHelper.deleteRecord(record.id);
    if (result != 0) {
      final snackBar = SnackBar(content: Text("Record deleted successfully"));
      Scaffold.of(context).showSnackBar(snackBar);
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = _databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Record>> recordListFuture = _databaseHelper.getRecordList();
      recordListFuture.then((recordList) {
        setState(() {
          this._recordList = recordList;
          this._count = recordList.length;
        });
      });
    });
  }
}
