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

// models/patrol_schedule_model.dart

/*class PatrolScheduleModel {
  final String email;
  final List<Map<String, Map<String, String>>> schedule;

  PatrolScheduleModel({
    required this.email,
    required this.schedule,
  });

  // Add a factory method to convert from a map
  factory PatrolScheduleModel.fromMap(Map<String, dynamic> map) {
    return PatrolScheduleModel(
      email: map['email'],
      schedule: List<Map<String, Map<String, String>>>.from(map['schedule']),
    );
  }
}*/

class PatrolScheduleModel {
  final String email;
  final List<Map<String, Map<String, String>>> schedule;

  PatrolScheduleModel({
    required this.email,
    required this.schedule,
  });

  // Factory constructor to create a PatrolScheduleModel from JSON data
  factory PatrolScheduleModel.fromJson(Map<String, dynamic> json) {
    return PatrolScheduleModel(
      email: json['email'],
      schedule: List<Map<String, Map<String, String>>>.from(json['schedule'].map(
            (entry) => Map<String, Map<String, String>>.from(entry),
      )),
    );
  }

  // Other methods or properties of your class, if any...

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'schedule': List<dynamic>.from(schedule.map(
            (x) => Map<String, Map<String, String>>.from(x),
      )),
    };
  }
}





