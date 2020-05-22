import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import '../questionaire_02/healthscore.dart';
import '../history/history.dart';
import '../globals.dart' as globals;

class QuestionairePage extends StatefulWidget {
  @override
  _QuestionairePageState createState() => _QuestionairePageState();
}

class _QuestionairePageState extends State<QuestionairePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<List<int>> finalAcquire = [];
  List<List<int>> finalDeduct = [];
  List<int> finalScore = List.generate(12, (index) => 0);
  //list is needed to be generated before any operation that call its element
  List<Map> finalQuestionaire = [];
  List<bool> checkBoxValue = [];

  List<String> results = [];

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/questions.txt');
  }

  void processFile() async {
    String assets = await loadAsset();
    results = assets.split("\n");

    for (int i = 0; i < results.length - 1; i++) {
      // results length is 6 after the last enter, so need to -1 up there
      checkBoxValue.add(false);
      String temp = results[i];
      List<String> templist;
      Map<String, dynamic> tempmap;
      templist = temp.split(":");
      templist[1] = templist[1].substring(1, templist[1].length - 2);
      //a blank space will be added to the end of line everytime enter is pressed, thus -2 instead of -1
      //-1 will cause radix-10 unrecognised error
      List<int> tempscore = templist[1]
          .split(",")
          .map(int.parse)
          .toList(); //list of string to list of int
      tempmap = {"Question": templist[0], "Score": tempscore};
      finalQuestionaire.add(tempmap);
    }
    setState(() {});
  }

  void finalProcess() {
    List<int> acquire = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    List<int> deduct = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    for (int j = 0; j < finalAcquire.length; j++) {
      for (int k = 0; k < finalAcquire[j].length; k++) {
        acquire[k] += finalAcquire[j][k];
      }
    }

    for (int j = 0; j < finalDeduct.length; j++) {
      for (int k = 0; k < finalDeduct[j].length; k++) {
        deduct[k] += finalDeduct[j][k];
      }
    }
    for (int k = 0; k < deduct.length; k++) {
      finalScore[k] = acquire.elementAt(k) - deduct.elementAt(k);
    }
  }

  void proceed() {
    finalProcess();
    globals.finalScore = finalScore;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HealthScore(), //pass idcontroller.text as argument
        ));
  }

  void refresh() {
    checkBoxValue.clear();
    checkBoxValue = List.generate(finalQuestionaire.length, (index) => false);
    finalAcquire.clear();
    finalDeduct.clear();
    List<int> temp = List.generate(12, (index) => 0);
    finalAcquire.add(temp);
    finalDeduct.add(temp);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    finalAcquire.add([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    finalDeduct.add([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    processFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            onTap: () {},
            title: Row(children: <Widget>[
              new Icon(Icons.question_answer),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: new Text("Questionaire"),
              )
            ]),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => History())),
            title: Row(children: <Widget>[
              new Icon(Icons.library_books),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: new Text("History"),
              )
            ]),
          ),
        ],
      )),
      appBar: new AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
        elevation: 15,
        backgroundColor: Colors.greenAccent,
        title: new Text("生活问卷", style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                refresh();
              }),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
          IconButton(
              icon: Icon(
                Icons.arrow_right,
                color: Colors.black,
              ),
              onPressed: () {
                globals.screenheight = MediaQuery.of(context).size.height;
                globals.screenwidth = MediaQuery.of(context).size.width;
                proceed();
              }),
        ],
      ),
      body: new Container(
          child: new Center(
        child: new ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: finalQuestionaire.length,
            itemBuilder: (BuildContext context, int index) {
              return questionBar(finalQuestionaire[index], index);
              //return new Text("num");
            }),
      )),
    );
  }

  Widget questionBar(Map question, int index) {
    int numbering = index + 1;

    Widget questionRow() {
      return new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              numbering.toString() +
                  ".".padRight(2) +
                  question["Question"].toString(),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: new Checkbox(
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  value: checkBoxValue[index],
                  onChanged: (bool result) {
                    if (result) {
                      finalAcquire.add(question["Score"]);
                      //print("checked");
                      setState(() {
                        checkBoxValue[index] = result;
                      });
                    } else {
                      finalDeduct.add(question["Score"]);
                      //print("unchecked");
                      setState(() {
                        checkBoxValue[index] = result;
                      });
                    }
                  }),
            ),
          ]);
    }

    Widget questionpart() {
      return new Column(children: <Widget>[
        Ink(
          color: Colors.blueAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: new Text(
                    numbering == 1 ? "=== Part 1 ===" : "=== Part 2 ===",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 25),
                  )),
            ],
          ),
        ),
        questionRow()
      ]);
    }

    return new Ink(
      color: numbering % 2 == 0 ? Colors.green[50] : Colors.blue[50],
      child: numbering == 1 || numbering == 38 ? questionpart() : questionRow(),
    );
  }
}
