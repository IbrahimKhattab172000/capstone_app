// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:capstone_app/constants/constants.dart';
import 'package:capstone_app/models/readings.dart';
import 'package:capstone_app/services/firebase_service.dart';
import 'package:capstone_app/widgets/add_test_button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Readings> readings = [];

  @override
  void initState() {
    super.initState();
    fetchData();
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
            FetchTestButton(
              onTap: () {
                fetchData();
              },
            ),
            const SizedBox(height: 50.0),
            Table(
              border: TableBorder.all(width: 5, color: secondaryColor),
              children: [
                TableRow(
                  children: [
                    _buildHeaderCell('Flow Rate'),
                    _buildHeaderCell('Heart Rate'),
                  ],
                ),
                for (var i = 0; i < 3; i++)
                  TableRow(
                    children: [
                      _buildDataCell(
                        readings.length > i
                            ? readings[readings.length - 1 - i]
                                .flowRate
                                .toString()
                            : '',
                        highlight: i == 0,
                      ),
                      _buildDataCell(
                        readings.length > i
                            ? readings[readings.length - 1 - i]
                                .heartRate
                                .toString()
                            : '',
                        highlight: i == 0,
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 20.0),
            _buildSection(
              'Instructions',
              "Monitor regularly and check your heart rate and flow rate regularly\n \nResting heart rate and understand your baseline resting heart rate\n\nConsult a professional if you notice consistent irregularities or have concerns about your heart rate or flow rate, consult a healthcare professional for personalized advice",
            ),
            const SizedBox(height: 10.0),
            _buildSection(
              'Suggestions',
              "Stay hydrated and maintain good hydration levels to support healthy blood flow\n \nExercise regularly and engage in regular physical activity for a healthy heart.",
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      List<Readings> fetchedReadings = await FirebaseService().fetchData();
      setState(() {
        readings = fetchedReadings;
      });
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }

  Widget _buildHeaderCell(String label) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: white),
      ),
      child: Text(label),
    );
  }

  Widget _buildDataCell(String data, {bool highlight = false}) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: highlight ? Colors.yellow : null,
      ),
      child: Text(
        data,
        style: TextStyle(
          color: highlight ? Colors.black : white,
          fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                content,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
