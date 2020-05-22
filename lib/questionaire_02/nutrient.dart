import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NutrientScore {
  final String nutrient;
  final int score;
  final charts.Color barColor;

  NutrientScore({
    @required this.nutrient,
    @required this.score,
    //@required this.barColor
  }) : barColor = score < 15
            ? charts.ColorUtil.fromDartColor(Colors.green)
            : score >= 30
                ? charts.ColorUtil.fromDartColor(Colors.red)
                : charts.ColorUtil.fromDartColor(Colors.yellow);
                
}
