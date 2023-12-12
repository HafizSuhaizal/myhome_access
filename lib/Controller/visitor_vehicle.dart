import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/visitor_vehicle.dart'; // Adjust this import path as necessary

class VisitorVehicleController {
  final CollectionReference _visitorsCollection = FirebaseFirestore.instance.collection('visitor');

  Future<String> registerVehicle(String plateNumber, DateTime startTime, DateTime endTime, String visitorName, String typeOfAccess, String vehicleType,String userId) async {
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
      userId:userId,
    );

    await _visitorsCollection.doc(plateNumber).set({
      'plateNumber': vehicle.plateNumber,
      'accessStartTime': vehicle.accessStartTime,
      'accessEndTime': vehicle.accessEndTime,
      'visitorName': vehicle.visitorName,
      'typeOfAccess': vehicle.typeOfAccess,
      'vehicleType': vehicle.vehicleType,
      'status': vehicle.status,
      'userId':vehicle.userId,
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
  Future<void> applyFine(String plateNumber) async {
    try {
      await _visitorsCollection.doc(plateNumber).update({'fined': true});
    } catch (e) {
      print("Error applying fine: $e");
    }
  }
  Future<VisitorVehicle?> getVehicleDetails(String plateNumber) async {
    var document = await _visitorsCollection.doc(plateNumber).get();
    if (document.exists) {
      return VisitorVehicle.fromFirestore(
          document.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
  Future<List<VisitorVehicle>> getRegisteredVehiclesByUser() async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return [];
    }

    var querySnapshot = await _visitorsCollection.where('userId', isEqualTo: userId).get();
    return querySnapshot.docs
        .map((doc) => VisitorVehicle.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
