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

