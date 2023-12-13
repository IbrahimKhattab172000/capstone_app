import 'package:capstone_app/models/readings.dart';
import 'package:capstone_app/screens/check_screen.dart';
import 'package:capstone_app/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ReadingWidgets extends StatefulWidget {
  const ReadingWidgets({super.key});

  @override
  State<ReadingWidgets> createState() => _ReadingWidgetsState();
}

class _ReadingWidgetsState extends State<ReadingWidgets> {
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

          data.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));

          return Column(
            children: [
              for (int i = 0; i < data.length; i++)
                DataRowWidget(
                  number: '${i + 1}⃣',
                  text:
                      'Flow rate: ${data[i].distance}   |   Heart rate: ${data[i].heartRate}',
                ),
            ],
          );
        });
  }
}
