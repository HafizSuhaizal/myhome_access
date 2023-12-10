 import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/emergency_alert.dart';

class EmergencyController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendEmergencyAlert(EmergencyAlert alert) async {
    await _firestore.collection('emergency_alerts').add({
      'type': alert.type,
      'message': alert.message,
      'imageUrl': alert.imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

class EmergencyAlert {
  String? id; // Made nullable
  String type;
  String message;
  String? imageUrl; // Made nullable
  DateTime? timestamp; // Made nullable
  EmergencyAlert({this.id, required this.type, required this.message, this.imageUrl, this.timestamp});
}
