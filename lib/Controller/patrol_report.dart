import 'package:cloud_firestore/cloud_firestore.dart';

class PatrolReportController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendPatrolReport(PatrolReport report) async {
    await _firestore.collection('patrol_report').add({
      'message': report.message,
      'imageUrl': report.imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

class PatrolReport {
  String? id; // Made nullable
  String message;
  String? imageUrl; // Made nullable
  DateTime? timestamp; // Made nullable
  PatrolReport({this.id, required this.message, this.imageUrl, this.timestamp});
}