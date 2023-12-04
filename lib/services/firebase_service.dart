import 'package:capstone_app/models/readings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addData(Readings readings) async {
    await _firestore.collection('readings').add({
      'heartRate': readings.heartRate,
      'flowRate': readings.flowRate,
      'timeStamp': readings.timeStamp,
    });
  }

  Future<List<Readings>> fetchData() async {
    QuerySnapshot querySnapshot = await _firestore.collection('readings').get();

    return querySnapshot.docs.map((DocumentSnapshot doc) {
      return Readings(
        heartRate: doc['heartRate'],
        flowRate: doc['flowRate'],
        timeStamp: doc['timeStamp'].toDate(),
      );
    }).toList();
  }
}
