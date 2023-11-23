import 'package:cloud_firestore/cloud_firestore.dart';

class VisitorVehicle {
  String plateNumber;
  DateTime accessStartTime;
  DateTime accessEndTime;
  String visitorName;
  String typeOfAccess;
  String vehicleType;
  String status;

  VisitorVehicle({
    required this.plateNumber,
    required this.accessStartTime,
    required this.accessEndTime,
    required this.visitorName,
    required this.typeOfAccess,
    required this.vehicleType,
    this.status = 'Access Granted',
  });

  bool get isAccessExpired => DateTime.now().isAfter(accessEndTime);

  void updateStatus() {
    if (isAccessExpired) {
      status = 'Access Denied';
    }
  }

  // Static method to create a VisitorVehicle from Firestore data
  static VisitorVehicle fromFirestore(Map<String, dynamic> firestoreData) {
    return VisitorVehicle(
      plateNumber: firestoreData['plateNumber'] as String? ?? '',
      accessStartTime: (firestoreData['accessStartTime'] as Timestamp).toDate(),
      accessEndTime: (firestoreData['accessEndTime'] as Timestamp).toDate(),
      visitorName: firestoreData['visitorName'] as String? ?? '',
      typeOfAccess: firestoreData['typeOfAccess'] as String? ?? '',
      vehicleType: firestoreData['vehicleType'] as String? ?? '',
      status: firestoreData['status'] as String? ?? 'Access Granted',
    );
  }
}
