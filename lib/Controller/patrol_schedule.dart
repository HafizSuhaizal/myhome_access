import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/patrol_schedule.dart';

class PatrolScheduleController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<PatrolScheduleModel>> getPatrolSchedule() {
    return _firestore.collection('patrolSchedule').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PatrolScheduleModel.fromMap(doc.data())).toList();
    });
  }
}
