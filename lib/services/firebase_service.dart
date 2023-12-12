import 'package:capstone_app/models/readings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Readings>> readingsStream() {
    return _firestore.collection('readings').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Readings.fromMap(doc.data())).toList());
  }

  Future<void> addData(Readings readings) async {
    await _firestore.collection('readings').add({
      'heartRate': readings.heartRate,
      'distance': readings.distance,
      'timeStamp': readings.timeStamp,
    });
  }

  Future<List<Readings>> fetchData() async {
    QuerySnapshot querySnapshot = await _firestore.collection('readings').get();

    return querySnapshot.docs.map((DocumentSnapshot doc) {
      return Readings(
        heartRate: doc['heartRate'],
        distance: doc['distance'],
        timeStamp: doc['timeStamp'].toDate(),
      );
    }).toList();
  }
}
