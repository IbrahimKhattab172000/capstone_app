import 'package:capstone_app/constants/constants.dart';
import 'package:capstone_app/widgets/add_test_button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AddTestButton(
              onTap: () {},
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
                TableRow(
                  children: [
                    _buildDataCell('120'),
                    _buildDataCell('100'),
                  ],
                ),
                TableRow(
                  children: [
                    _buildDataCell('130'),
                    _buildDataCell('120'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            _buildSection('Instructions',
                "Monitor regularly and heck your heart rate and flow rate regularly\n \nResting heart rate and understand your baseline resting heart rate\n\nConsult a professional if you notice consistent irregularities or have concerns about your heart rate or flow rate, consult a healthcare professional for personalized advice"),
            const SizedBox(height: 10.0),
            _buildSection('Suggestions',
                "Stay hydrated and maintain good hydration levels to support healthy blood flow\n \nExercise regularly and engage in regular physical activity for a healthy heart."),
          ],
        ),
      ),
    );
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

  Widget _buildDataCell(String data) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Text(data, style: TextStyle(color: white)),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      height: 180, // Reduced height
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
