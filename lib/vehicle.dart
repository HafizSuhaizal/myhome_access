import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Vehicle extends StatefulWidget {
  const Vehicle({super.key});

  @override
  State<Vehicle> createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _plateNumberEditingController = TextEditingController();
  final TextEditingController _vehicleTypeEditingController = TextEditingController();

  void _handleExistingVehicle() async {
    if (_formKey.currentState!.validate()) {
      String ownerName = _nameEditingController.text.trim();
      String plateNumber = _plateNumberEditingController.text.trim();
      String vehicleType = _vehicleTypeEditingController.text.trim();

      var existingVehicle = await findVehicleByPlateNumber(plateNumber);
      if (existingVehicle != null) {
        // If the vehicle already exists, show a snackbar message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Plate Number already exists')),
        );
      } else {
        try {
          var collection = FirebaseFirestore.instance.collection('vehicle');
          await collection.doc(plateNumber).set({
            'name': ownerName,
            'platenumber': plateNumber,
            'typeofvehicle': vehicleType,
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('New Vehicle Added')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding vehicle: $e')),
          );
        }
      }
    }
  }

  Future<DocumentSnapshot?> findVehicleByPlateNumber(String plateNumber) async {
    try {
      var collection = FirebaseFirestore.instance.collection('vehicle');
      var docSnapshot = await collection.doc(plateNumber).get();

      if (docSnapshot.exists) {
        return docSnapshot;
      }
      return null;
    } catch (e) {
      print("Error finding vehicle: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add/Update Vehicle")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameEditingController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Owner Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter owner name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _plateNumberEditingController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Plate Number",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter plate number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _vehicleTypeEditingController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Vehicle Type",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter vehicle type";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleExistingVehicle,
                  child: const Text("Add/Update Vehicle"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
