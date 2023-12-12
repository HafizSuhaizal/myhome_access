import 'package:flutter/material.dart';
import '../Controller/visitor_vehicle.dart';
import '../Model/visitor_vehicle.dart'; // Adjust the import path as necessary

class RegisteredVehiclesView extends StatefulWidget {
  @override
  _RegisteredVehiclesViewState createState() => _RegisteredVehiclesViewState();
}

class _RegisteredVehiclesViewState extends State<RegisteredVehiclesView> {
  final VisitorVehicleController _visitorVehicleController = VisitorVehicleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Registered Vehicles'),
      ),
      body: FutureBuilder<List<VisitorVehicle>>(
        future: _visitorVehicleController.getRegisteredVehiclesByUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No registered vehicles found'));
          }
          List<VisitorVehicle> vehicles = snapshot.data!;
          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              VisitorVehicle vehicle = vehicles[index];
              return ListTile(
                title: Text(vehicle.visitorName),
                subtitle: Text(
                  'Plate Number: ${vehicle.plateNumber}\n'
                      'Access Time: ${vehicle.accessStartTime} - ${vehicle.accessEndTime}\n'
                      'Type of Access: ${vehicle.typeOfAccess}\n'
                      'Vehicle Type: ${vehicle.vehicleType}\n'
                      'Status: ${vehicle.status}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
