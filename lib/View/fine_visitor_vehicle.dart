import 'package:flutter/material.dart';

import '../Controller/visitor_vehicle.dart';

class PatrolScreen extends StatefulWidget {
  @override
  _PatrolScreenState createState() => _PatrolScreenState();
}

class _PatrolScreenState extends State<PatrolScreen> {
  final VisitorVehicleController _controller = VisitorVehicleController();
  final TextEditingController _plateNumberController = TextEditingController();
  String _statusMessage = '';
  bool _showFineButton = false;

  void _checkVehicle() async {
    var plateNumber = _plateNumberController.text;

    try {
      var vehicle = await _controller.getVehicleDetails(plateNumber);
      if (vehicle != null) {
        setState(() {
          _statusMessage = 'Status: ${vehicle.status}';
          _showFineButton = vehicle.isAccessExpired; // Show the button if access is denied
        });
      } else {
        setState(() {
          _statusMessage = 'Vehicle not found';
          _showFineButton = false;
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: $e';
        _showFineButton = false;
      });
    }
  }

  void _applyFine() async {
    var plateNumber = _plateNumberController.text;

    try {
      await _controller.applyFine(plateNumber);
      setState(() {
        _statusMessage = 'Fine applied';
        _showFineButton = false;
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error applying fine: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrol Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _plateNumberController,
              decoration: InputDecoration(
                labelText: 'Enter Plate Number',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _checkVehicle,
              child: Text('Check Vehicle'),
            ),
            Text(_statusMessage),
            if (_showFineButton)
              ElevatedButton(
                onPressed: _applyFine,
                child: Text('Apply Fine'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
