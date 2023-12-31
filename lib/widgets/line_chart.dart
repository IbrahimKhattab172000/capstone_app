import 'package:capstone_app/models/readings.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class LineChart extends StatelessWidget {
  final String title;
  final List<Readings> data;
  final Color color;

  const LineChart({
    super.key,
    required this.title,
    required this.data,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(
        text: title,
        backgroundColor: Colors.white,
        alignment: ChartAlignment.center,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<Readings, String>>[
        LineSeries<Readings, String>(
          dataSource: data,
          color: Colors.transparent, // Set line color to transparent
          pointColorMapper: (Readings readings, _) =>
              Colors.white, // Set point color to white
          xValueMapper: (Readings readings, _) =>
              DateFormat('MM/dd HH:mm').format(readings.timeStamp.toLocal()),
          yValueMapper: (Readings readings, _) => title == 'Heart Rate'
              ? readings.heartRate.toDouble()
              : readings.distance.toDouble(),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle:
                TextStyle(color: Colors.white), // Set text color to white
          ),
        ),
      ],
    );
  }
}
