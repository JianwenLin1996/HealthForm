import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../record/record.dart';

class HistoryDetail extends StatefulWidget {
  final Record record_detail;
  HistoryDetail(this.record_detail);
  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        elevation: 15,
        backgroundColor: Colors.greenAccent,
        title: new Text("存档", style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.pink[50],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          upper(widget.record_detail.name),
                          upper(widget.record_detail.date)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                height: globals.screenheight * 0.13,
                                child: Card(
                                  elevation: 5.0,
                                  child: Center(
                                      child: new Text(
                                    widget.record_detail.description,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20),
                                  )),
                                )),
                          ),
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                height: globals.screenheight * 0.5,
                                child: Card(
                                  elevation: 5.0,
                                  child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                        nutrientscore(1),
                                        nutrientscore(2),
                                        nutrientscore(3),
                                        nutrientscore(4),
                                        nutrientscore(5),
                                        nutrientscore(6),
                                      ])),
                                )),
                          ),
                        ],
                      )),
                ],
              ),
            )),
      ),
    );
  }

  Widget upper(String input) {
    return Expanded(
        child: Card(
            elevation: 5.0,
            child: Container(
                height: globals.screenheight * 0.15,
                child: Center(
                    child: new Text(
                  input,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                )))));
  }

  Widget nutrientscore(int numOfRow) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        everyrow(2 * numOfRow - 2),
        everyrow(2 * numOfRow - 1)
      ],
    );
  }

  Widget everyrow(int number) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 2,
            color: widget.record_detail.score[number] < 15
                ? Colors.green
                : widget.record_detail.score[number] < 30
                    ? Colors.yellow
                    : Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      width: globals.screenwidth * 0.4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(3, 3, 8, 3),
                child: Container(
                    width: globals.screenwidth * 0.2,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(globals.nutrientname[number])))),
            Padding(
                padding: EdgeInsets.fromLTRB(8, 3, 3, 3),
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.record_detail.score[number].toString(),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
