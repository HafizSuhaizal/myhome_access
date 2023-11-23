import 'package:flutter/material.dart';
import '../Controller/vehicle_controller.dart';
import '../Model/vehicle_model.dart';

class VehicleView extends StatefulWidget {
  @override
  _VehicleViewState createState() => _VehicleViewState();
}

class _VehicleViewState extends State<VehicleView> {
  final VehicleController _vehicleController = VehicleController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _plateNumberEditingController = TextEditingController();
  final TextEditingController _vehicleTypeEditingController = TextEditingController();

  void _handleExistingVehicle() async {
    if (_formKey.currentState!.validate()) {
      String ownerName = _nameEditingController.text.trim();
      String plateNumber = _plateNumberEditingController.text.trim();
      String vehicleType = _vehicleTypeEditingController.text.trim();

      var existingVehicle = await _vehicleController.findVehicleByPlateNumber(plateNumber);
      if (existingVehicle != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Plate Number already exists')));
      } else {
        await _vehicleController.addOrUpdateVehicle(VehicleModel(ownerName: ownerName, plateNumber: plateNumber, vehicleType: vehicleType));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New Vehicle Added')));
      }
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
