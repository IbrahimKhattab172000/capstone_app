// ignore_for_file: public_member_api_docs, sort_constructors_first
// New widget to display health recommendation
import 'package:capstone_app/services/firebase_service.dart';
import 'package:flutter/material.dart';

import 'package:capstone_app/helpers/suggestion_helper.dart';
import 'package:capstone_app/models/readings.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({
    Key? key,
  }) : super(key: key);

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
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
//We should always give suggestions depending on the latest distance
          Readings latestReading = data.first;
          return SuggestionWidget(
            recommendation: SuggestionHelper.generateSuggestion(
              distance: latestReading.distance,
              // heartRate: data.first.heartRate,
            ),
          );
        });
  }
}

class SuggestionWidget extends StatelessWidget {
  final SuggestionData recommendation;

  const SuggestionWidget({Key? key, required this.recommendation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Suggestions',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          if (recommendation.text.isNotEmpty)
            Column(
              children: [
                Text(
                  recommendation.text,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          if (recommendation.text.isEmpty)
            const Text(
              'No health recommendation available',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
        ],
      ),
    );
  }
}
