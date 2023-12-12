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


// model.dart
import 'package:cloud_firestore/cloud_firestore.dart';


/*class PatrolSchedule {
  final String guard1;
  final String guard2;
  final String guard3;

  PatrolSchedule({required this.guard1, required this.guard2, required this.guard3});

 *//* factory PatrolSchedule.fromJson(Map<String, dynamic> json) {
    return PatrolSchedule(
      guard1: json['guard1'],
      guard2: json['guard2'],
      guard3: json['guard3'],
    );
  }*//*
}*/
class PatrolScheduleModel {
  String? guardName;
  String? dayName;
  String? day;
  String? shift;
  String? startTime;

  PatrolScheduleModel({this.guardName, this.dayName, this.day, this.shift, this.startTime});

  factory PatrolScheduleModel.fromMap(Map<String, dynamic> map) {
    return PatrolScheduleModel(
      guardName: map['guardName'],
      dayName: map['dayName'],
      day: map['day'],
      shift: map['shift'],
      startTime: map['startTime'],
    );
  }
}
