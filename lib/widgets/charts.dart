import 'package:capstone_app/models/readings.dart';
import 'package:capstone_app/services/firebase_service.dart';
import 'package:capstone_app/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  final FirebaseService _firebaseService = FirebaseService();

  List<Readings> data = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    List<Readings> fetchedData = await _firebaseService.fetchData();

    setState(() {
      data = fetchedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LineChart(
          title: 'Heart Rate',
          data: data,
          color: Colors.white,
        ),
        LineChart(
          title: 'Flow Rate',
          data: data,
          color: Colors.white,
        ),
      ],
    );
  }
}
