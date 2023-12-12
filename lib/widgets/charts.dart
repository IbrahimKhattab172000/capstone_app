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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Readings>>(
      stream: _firebaseService.readingsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        List<Readings> data = snapshot.data!;

        print('Received Data: $data'); // Print received data for debugging.

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
      },
    );
  }
}
