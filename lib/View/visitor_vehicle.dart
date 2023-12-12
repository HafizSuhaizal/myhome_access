import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Controller/visitor_vehicle.dart';

class VisitorRegistrationView extends StatefulWidget {
  @override
  _VisitorRegistrationViewState createState() => _VisitorRegistrationViewState();
}

class _VisitorRegistrationViewState extends State<VisitorRegistrationView> {
  final VisitorVehicleController _controller = VisitorVehicleController();
  final TextEditingController _plateNumberController = TextEditingController();
  final TextEditingController _visitorNameController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  DateTime _selectedStartTime = DateTime.now();
  DateTime _selectedEndTime = DateTime.now().add(Duration(hours: 2));
  String _selectedAccessType = 'visitor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Visitor Vehicle")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _plateNumberController,
              decoration: InputDecoration(labelText: 'Plate Number'),
            ),
            TextField(
              controller: _visitorNameController,
              decoration: InputDecoration(labelText: 'Visitor Name'),
            ),
            TextField(
              controller: _vehicleTypeController,
              decoration: InputDecoration(labelText: 'Vehicle Type'),
            ),
            ListTile(
              title: Text("Start Time: ${_selectedStartTime.toIso8601String()}"),
              onTap: () async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: _selectedStartTime,
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (date != null) {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_selectedStartTime),
                  );
                  if (time != null) {
                    setState(() {
                      _selectedStartTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  }
                }
              },
            ),
            ListTile(
              title: Text("End Time: ${_selectedEndTime.toIso8601String()}"),
              onTap: () async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: _selectedEndTime,
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (date != null) {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_selectedEndTime),
                  );
                  if (time != null) {
                    setState(() {
                      _selectedEndTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  }
                }
              },
            ),
            DropdownButton<String>(
              value: _selectedAccessType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAccessType = newValue!;
                });
              },
              items: <String>['visitor', 'tenant']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                var userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_user'; // Get current user's ID
                try {
                  String result = await _controller.registerVehicle(
                    _plateNumberController.text,
                    _selectedStartTime,
                    _selectedEndTime,
                    _visitorNameController.text,
                    _selectedAccessType,
                    _vehicleTypeController.text,
                    userId, // Pass the user ID
                  );
                  _showDialog(context, result);
                } catch (e) {
                  _showDialog(context, 'Error: ${e.toString()}');
                }
              },
              child: Text('Register Vehicle'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }
}
