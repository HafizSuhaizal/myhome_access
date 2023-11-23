import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/visitor_vehicle.dart'; // Adjust this import path as necessary

class VisitorVehicleController {
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
}