/*import 'package:cloud_firestore/cloud_firestore.dart';

class PatrolSchedule{
  String guardName;
  DateTime accessStartTime;
  DateTime accessEndTime;

  PatrolSchedule({
    required this.guardName,
    required this.accessStartTime,
    required this.accessEndTime,

  });

  // Static method to create a PatrolSchedule from Firestore data
  static PatrolSchedule fromFirestore(Map<String, dynamic> firestoreData) {
    return PatrolSchedule(
      guardName: firestoreData['guardName'] as String? ?? '',
      accessStartTime: (firestoreData['accessStartTime'] as Timestamp).toDate(),
      accessEndTime: (firestoreData['accessEndTime'] as Timestamp).toDate(),

    );
  }

}*/
