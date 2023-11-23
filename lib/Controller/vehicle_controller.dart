import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/vehicle_model.dart';

class VehicleController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot?> findVehicleByPlateNumber(String plateNumber) async {
    try {
      var docSnapshot = await _firebaseFirestore.collection('vehicle').doc(plateNumber).get();
      return docSnapshot.exists ? docSnapshot : null;
    } catch (e) {
      print("Error finding vehicle: $e");
      return null;
    }
  }

  Future<void> addOrUpdateVehicle(VehicleModel vehicle) async {
    await _firebaseFirestore.collection('vehicle').doc(vehicle.plateNumber).set({
      'name': vehicle.ownerName,
      'platenumber': vehicle.plateNumber,
      'typeofvehicle': vehicle.vehicleType,
    });
  }
}
