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
