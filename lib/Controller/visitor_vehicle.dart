import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/visitor_vehicle.dart';
import 'visitor_vehicle.dart';

class VisitorVehicleController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _visitorsCollection = FirebaseFirestore.instance.collection('visitor');

  Future<String> registerVehicle(String plateNumber, DateTime startTime, DateTime endTime, String visitorName, String typeOfAccess, String vehicleType) async {
    var existingVehicle = await _visitorsCollection.doc(plateNumber).get();
    if (existingVehicle.exists) {
      return "Plate Number already registered";
    }

    var vehicle = VisitorVehicle(
      plateNumber: plateNumber,
      accessStartTime: startTime,
      accessEndTime: endTime,
      visitorName: visitorName,
      typeOfAccess: typeOfAccess,
      vehicleType: vehicleType,
    );

    await _visitorsCollection.doc(plateNumber).set({
      'plateNumber': vehicle.plateNumber,
      'accessStartTime': vehicle.accessStartTime,
      'accessEndTime': vehicle.accessEndTime,
      'visitorName': vehicle.visitorName,
      'typeOfAccess': vehicle.typeOfAccess,
      'vehicleType': vehicle.vehicleType,
      'status': vehicle.status,
    });

    return "Vehicle successfully registered";
  }

  Future<List<VisitorVehicle>> getRegisteredVehicles() async {
    var querySnapshot = await _visitorsCollection.get();
    return querySnapshot.docs.map((doc) => VisitorVehicle.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> updateVehicleStatuses() async {
    var querySnapshot = await _visitorsCollection.get();
    for (var doc in querySnapshot.docs) {
      var vehicle = VisitorVehicle.fromFirestore(doc.data() as Map<String, dynamic>);
      if (vehicle.isAccessExpired) {
        await doc.reference.update({'status': 'Access Denied'});
      }
    }
  }

  // Helper method to create a VisitorVehicle from Firestore data
  static VisitorVehicle fromFirestore(Map<String, dynamic> firestoreData) {
    return VisitorVehicle(
      plateNumber: firestoreData['plateNumber'],
      accessStartTime: (firestoreData['accessStartTime'] as Timestamp).toDate(),
      accessEndTime: (firestoreData['accessEndTime'] as Timestamp).toDate(),
      visitorName: firestoreData['visitorName'],
      typeOfAccess: firestoreData['typeOfAccess'],
      vehicleType: firestoreData['vehicleType'],
      status: firestoreData['status'],
    );
  }
  static VisitorVehicle fromFirestore(Map<String, dynamic> firestoreData) {
    return VisitorVehicle(
      plateNumber: firestoreData['plateNumber'],
      accessStartTime: (firestoreData['accessStartTime'] as Timestamp).toDate(),
      accessEndTime: (firestoreData['accessEndTime'] as Timestamp).toDate(),
      visitorName: firestoreData['visitorName'],
      typeOfAccess: firestoreData['typeOfAccess'],
      vehicleType: firestoreData['vehicleType'],
      status: firestoreData['status'] ?? 'Access Granted',
    );
}
