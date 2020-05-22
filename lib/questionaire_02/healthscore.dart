import 'package:flutter/material.dart';
import './nutrient.dart';
import './nutrient_chart.dart';
import './healthscorestat.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
import '../globals.dart' as globals;

class HealthScore extends StatefulWidget {
  @override
  _HealthScoreState createState() => _HealthScoreState();
}

class _HealthScoreState extends State<HealthScore> {
  PageController _myPage = PageController(initialPage: 0);
  Color firstnav = Colors.amber[200];
  Color secondnav = Colors.greenAccent;

  @override
  void initState() {
    super.initState();
  }

  void switchcolour (){
    Color temp = firstnav;
    firstnav = secondnav;
    secondnav = temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 15,
          backgroundColor: Colors.greenAccent,
          title: new Text("健康报告", style: TextStyle(color: Colors.black)),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Colors.white,
            //height: MediaQuery.of(context).size.height * 0.08,
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: firstnav,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _myPage.jumpToPage(0);
                          });
                        },
                        child: new Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                          new Text("条形图", style: TextStyle(fontWeight: FontWeight.w300)),
                          new Text("Bar Chart", style: TextStyle(fontWeight: FontWeight.w300),)
                        ])),
                  ),
                ),
                new Text(
                  " | ",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                ),
                Expanded(
                  child: Container(
                    color: secondnav,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _myPage.jumpToPage(1);
                          });
                        },
                        child: new Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                          new Text("数据", style: TextStyle(fontWeight: FontWeight.w300)),
                          new Text("Statistics", style: TextStyle(fontWeight: FontWeight.w300))
                        ])),
                  ),
                ),
              ],
            ),
          ),
          color: Colors.blueGrey,
        ),
        body: PageView(
            controller: _myPage,
            onPageChanged: (int page) {setState(() {
               switchcolour();
            });},
            //physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              new Container(
                child: Center(
                  child: new Column(
                    children: <Widget>[
                      NutrientChart(
                        data: data,
                      )
                    ],
                  ),
                ),
              ),
              HealthScoreStat()
            ]));
  }

  final List<NutrientScore> data = [
    NutrientScore(
      nutrient: globals.nutrientname[0], //must be different for all object
      score: globals.finalScore[0],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[1],
      score: globals.finalScore[1],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[2],
      score: globals.finalScore[2],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[3],
      score: globals.finalScore[3],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[4],
      score: globals.finalScore[4],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[5],
      score: globals.finalScore[5],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[6],
      score: globals.finalScore[6],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[7],
      score: globals.finalScore[7],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[8],
      score: globals.finalScore[8],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[9],
      score: globals.finalScore[9],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[10],
      score: globals.finalScore[10],
    ),
    NutrientScore(
      nutrient: globals.nutrientname[11],
      score: globals.finalScore[11],
    ),
  ];
}
