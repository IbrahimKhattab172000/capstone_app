import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CountDownWidget extends StatelessWidget {
  const CountDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circular background for the countdown timer
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 6.0),
              ),
            ),

            // Countdown timer
            CountdownTimer(
              endTime: calculateEndTime(),
              textStyle: TextStyle(fontSize: 20, color: Colors.blue),
              onEnd: () {
                // Add any action you want to perform when the countdown ends
                print('Countdown ended!');
              },
            ),
          ],
        ),
      ),
    );
  }
}

int calculateEndTime() {
  DateTime now = DateTime.now();
  DateTime testTime = DateTime(now.year, now.month, now.day, 8, 0, 0);

  // Adjust for Egyptian time (UTC+2)
  testTime = testTime.add(const Duration(hours: 2));

  if (now.isAfter(testTime)) {
    // If it's already past 8 am, set the countdown for the next day
    testTime = testTime.add(const Duration(days: 1));
  }

  return testTime.millisecondsSinceEpoch;
}
