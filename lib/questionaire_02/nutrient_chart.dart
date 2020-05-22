import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import './nutrient.dart';

class NutrientChart extends StatelessWidget {
  final List<NutrientScore> data;
  NutrientChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<NutrientScore, String>> series = [
      charts.Series(
        id: "Nutrient Scores",
        data: data,
        domainFn: (NutrientScore series, _) => series.nutrient,
        measureFn: (NutrientScore series, _) => series.score,
        labelAccessorFn: (NutrientScore series, _) => "${series.score}",
        colorFn: (NutrientScore series, _) => series.barColor,        
      )
    ];

    return new Expanded(
        child: Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: charts.BarChart(
        series,
        animate: true,
        vertical: false,
        domainAxis: new charts.OrdinalAxisSpec(
            renderSpec: new charts.SmallTickRendererSpec(
                labelStyle: new charts.TextStyleSpec(
                    fontSize: 10, color: charts.MaterialPalette.black))),
        //barRendererDecorator: new charts.BarLabelDecorator<String>(),
        //above just assign name, not value
      ),
    ));
  }
}
