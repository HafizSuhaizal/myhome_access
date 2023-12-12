/*import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/patrol_schedule.dart';

class PatrolScheduleController {
  final CollectionReference guardsCollection =
  FirebaseFirestore.instance.collection('Schedule');

  Future<String> addSchedule(
      String guardName,
      DateTime startTime,
      DateTime endTime
      ) async {
    var existingschedule = await guardsCollection.doc(guardName).get();
    if (existingschedule.exists) {
      return "The guard has already occupied";
    }

    var schedule = PatrolSchedule(
      guardName: guardName,
      accessStartTime: startTime,
      accessEndTime: endTime,
    );

    await guardsCollection.doc(guardName).set({
      'guardName': schedule.guardName,
      'accessStartTime': schedule.accessStartTime,
      'accessEndTime': schedule.accessEndTime,

    });

    return "Schedule successfully added!";
  }

  Future<List<PatrolSchedule>> getRegisteredVehicles() async {
    var querySnapshot = await guardsCollection.get();
    return querySnapshot.docs.map((doc) => PatrolSchedule.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }
}*/

// controller.dart
/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/patrol_schedule.dart';

class PatrolController {
  Future<void> generateRandomPatrolSchedule() async {
    final url = 'https://us-central1-myhomeaccess-365ff.cloudfunctions.net/generateRandomPatrolSchedule'; // Replace with your actual Firebase Cloud Function URL

    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        // Successful response
        final data = jsonDecode(response.body);
        final schedule = Map<String, PatrolSchedule>.from(data['schedule']);
        print('Response: $data');

        // Handle the schedule data as needed
      } else {
        // Error response
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any network or request errors
      print('Error: $error');
    }
  }
}
*/

// controllers/patrol_schedule_controller.dart

// Import necessary packages and model
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/patrol_schedule.dart'; // Adjust this import path as necessary

class PatrolScheduleController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> generatePatrolSchedule() async {
    try {
      final guardUsersSnapshot = await _firestore.collection('users').where('role', isEqualTo: 'Guard').get();

      final schedules = <PatrolScheduleModel>[];

      List<Map<String, dynamic>> generateUserSchedule() {
        const daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        const shifts = ['Morning', 'Night'];

        final userSchedule = <Map<String, dynamic>>[];

        for (final day in daysOfWeek) {
          final daySchedule = <String, dynamic>{};

          for (final shift in shifts) {
            daySchedule[shift] = {'guard': 'Assigned Guard'};
          }

          userSchedule.add({'day': day, 'shifts': daySchedule});
        }

        return userSchedule;
      }

      Map<String, dynamic> getFairGuard(DocumentSnapshot doc) {
        return {
          'email': doc['email'],
          'schedule': generateUserSchedule(),
        };
      }

      for (final doc in guardUsersSnapshot.docs) {
        final fairGuard = getFairGuard(doc);
        schedules.add(PatrolScheduleModel.fromMap(fairGuard));
      }

      await _firestore.collection('patrolschedule').doc('schedules').set({'schedules': schedules});

      print('Patrol schedules generated and updated in the "patrolschedule" collection.');
    } catch (error) {
      print('Error generating patrol schedules: $error');
      throw error;
    }
  }

  Future<List<PatrolScheduleModel>> getAllPatrolSchedules() async {
    try {
      final usersSnapshot = await _firestore.collection("users").get();

      final allPatrolSchedules = <PatrolScheduleModel>[];
      for (final userDoc in usersSnapshot.docs) {
        if (userDoc.exists) {
          final data = userDoc.data();
          if (data != null && data.containsKey('patrolSchedule')) {
            final List<dynamic> scheduleData = data['patrolSchedule'];
            List<PatrolScheduleModel> userPatrolSchedules =
            scheduleData.map((entry) => PatrolScheduleModel.fromJson(entry)).toList();
            allPatrolSchedules.addAll(userPatrolSchedules);
          }
        }
      }

      return allPatrolSchedules;
    } catch (error) {
      print('Error fetching patrol schedules: $error');
      throw error;
    }
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/patrol_schedule.dart'; // Adjust this import path as necessary

class PatrolScheduleController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> generatePatrolSchedule() async {
    try {
      final guardUsersSnapshot = await _firestore.collection('users').where('role', isEqualTo: 'Guard').get();

      final schedules = <PatrolScheduleModel>[];

      List<Map<String, dynamic>> generateUserSchedule() {
        const daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        const shifts = ['Morning', 'Night'];

        final userSchedule = <Map<String, dynamic>>[];

        for (final day in daysOfWeek) {
          final daySchedule = <String, dynamic>{};

          for (final shift in shifts) {
            daySchedule[shift] = {'guard': 'Assigned Guard'};
          }

          userSchedule.add({'day': day, 'shifts': daySchedule});
        }

        return userSchedule;
      }

      Map<String, dynamic> getFairGuard(DocumentSnapshot doc) {
        return {
          'email': doc['email'],
          'schedule': generateUserSchedule(),
        };
      }

      for (final doc in guardUsersSnapshot.docs) {
        final fairGuard = getFairGuard(doc);
        schedules.add(PatrolScheduleModel.fromJson(fairGuard));
      }

      await _firestore.collection('patrolschedule').doc('schedules').set({'schedules': schedules});

      print('Patrol schedules generated and updated in the "patrolschedule" collection.');
    } catch (error) {
      print('Error generating patrol schedules: $error');
      throw error;
    }
  }

  Future<List<PatrolScheduleModel>> getAllPatrolSchedules() async {
    try {
      final usersSnapshot = await _firestore.collection("users").get();

      final allPatrolSchedules = <PatrolScheduleModel>[];
      for (final userDoc in usersSnapshot.docs) {
        if (userDoc.exists) {
          final data = userDoc.data();
          if (data != null && data.containsKey('patrolSchedule')) {
            final List<dynamic> scheduleData = data['patrolSchedule'];
            List<PatrolScheduleModel> userPatrolSchedules =
            scheduleData.map((entry) => PatrolScheduleModel.fromJson(entry)).toList();
            allPatrolSchedules.addAll(userPatrolSchedules);
          }
        }
      }

      return allPatrolSchedules;
    } catch (error) {
      print('Error fetching patrol schedules: $error');
      throw error;
    }
  }
}






