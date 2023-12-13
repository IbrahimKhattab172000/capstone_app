// ignore_for_file: avoid_print

import 'package:capstone_app/constants/constants.dart';
import 'package:capstone_app/models/readings.dart';
import 'package:capstone_app/services/firebase_service.dart';
import 'package:capstone_app/widgets/charts.dart';
import 'package:capstone_app/widgets/countdown_clock.dart';
import 'package:capstone_app/widgets/reading_widgets.dart';
import 'package:flutter/material.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  final FirebaseService _firebaseService = FirebaseService();

  List<Readings> _data = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAndFilterThenGetTheLatest3Readings();
  }

  fetchAndFilterThenGetTheLatest3Readings() async {
    try {
      List<Readings> data = await _firebaseService.fetchData();

      // Sort the data by timestamp in descending order
      data.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));

      // Take the first 3 elements (latest 3 readings)
      _data = data.take(3).toList();
    } catch (e) {
      // Handle errors gracefully
      print('Error fetching data: $e');
    } finally {
      // Set isLoading to false when the fetch operation is completed
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Next test should be in',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
            const SizedBox(height: 10.0),
            // Assuming CountDownWidget is already defined
            const CountDownWidget(),
            const SizedBox(height: 20.0),

            const Charts(),
            const SizedBox(height: 20.0),

            const ReadingWidgets(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class DataRowWidget extends StatelessWidget {
  final String number;
  final String text;

  const DataRowWidget({
    Key? key,
    required this.number,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
