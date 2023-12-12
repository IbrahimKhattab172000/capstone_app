import 'package:cloud_firestore/cloud_firestore.dart';

class Readings {
  int distance;
  int heartRate;
  DateTime timeStamp;
  Readings({
    required this.distance,
    required this.heartRate,
    required this.timeStamp,
  });

  factory Readings.fromMap(Map<String, dynamic> map) {
    return Readings(
      distance: map['distance'] ?? 0,
      heartRate: map['heartRate'] ?? 0,
      timeStamp: (map['timeStamp'] as Timestamp).toDate(),
    );
  }
}
