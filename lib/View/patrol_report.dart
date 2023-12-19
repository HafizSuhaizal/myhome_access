/*
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../Controller/patrol_report.dart';
import '../Model/patrol_report.dart';

class PatrolReportScreen extends StatefulWidget {
  final String userEmail;
  //PatrolReportScreen({required this.userEmail});

  PatrolReportScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  _PatrolReportScreenState createState() => _PatrolReportScreenState();
}

class _PatrolReportScreenState extends State<PatrolReportScreen> {
  final PatrolReportController _controller = PatrolReportController();
  CameraController? cameraController;
  Future<void>? initializeControllerFuture;
  String GuardName = '';

  String _message = '';
  Uint8List? _imageBytes;

  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initCamera();
    _fetchGuardName();
  }

  void _fetchGuardName() async {
    // Logic to fetch owner name based on user role
    String roleName = 'Guard'; // Replace with the actual role check logic
    if (roleName == 'Guard') {
      GuardName = (await _controller.fetchGuardName()) ?? ''; // Update with your controller method
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    initializeControllerFuture = cameraController?.initialize();
  }

  Future<void> takePicture() async {
    try {
      await initializeControllerFuture;
      final picture = await cameraController!.takePicture();
      setState(() {
        _imageBytes = picture.path as Uint8List?;
      });
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _showSubmitSuccessDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Report has been successfully submitted!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrol Report'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Submit Your Patrol Report',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _messageController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _message = value,
              ),
              SizedBox(height: 20),
              _imageBytes != null
                  ? Image.file(File(_imageBytes! as String))
                  : ElevatedButton(
                onPressed: takePicture,
                child: Text('Take Picture'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var report = PatrolReport(
                    GuardName:GuardName,
                    message: _message,
                    imageBytes: _imageBytes,
                    timestamp: DateTime.now(),
                  );
                  await _controller.sendPatrolReport(report);
                  _showSubmitSuccessDialog();
                },
                child: Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PatrolReportView extends StatelessWidget {
  final PatrolReportController _patrolReportController = PatrolReportController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrol Reports'),
      ),
      body: StreamBuilder<List<PatrolReport>>(
        stream: _patrolReportController.getPatrolReports(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No patrol reports available.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              PatrolReport report = snapshot.data![index];
              return ListTile(
                title: Text(report.GuardName ?? 'Guard Name not available'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report.message ?? 'No message'),
                    if (report.imageBytes != null)
                      Image.network(
                        report.imageBytes! as String,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    Text(
                      report.timestamp != null
                          ? 'Timestamp: ${report.timestamp!.toString()}'
                          : 'No timestamp',
                    ),
                  ],
                ),
                // You can customize the ListTile to include more information if needed
                // For example, you can add buttons for actions related to the report.
                // trailing: Row(
                //   children: [
                //     IconButton(
                //       icon: Icon(Icons.edit),
                //       onPressed: () => editReport(report),
                //     ),
                //     IconButton(
                //       icon: Icon(Icons.delete),
                //       onPressed: () => deleteReport(report),
                //     ),
                //   ],
                // ),
              );
            },
          );
        },
      ),
    );
  }
}
*/


import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import '../Controller/patrol_report.dart';
import '../Model/patrol_report.dart';

class PatrolReportScreen extends StatefulWidget {
  final String userEmail;

  PatrolReportScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  _PatrolReportScreenState createState() => _PatrolReportScreenState();
}

class _PatrolReportScreenState extends State<PatrolReportScreen> {
  final PatrolReportController _controller = PatrolReportController();
  CameraController? cameraController;
  Future<void>? initializeControllerFuture;
  String guardName = '';

  String _message = '';
  Uint8List? _imageBytes;

  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchGuardName();
    initCamera();
  }

  void _fetchGuardName() async {
    // Replace this logic with your own logic to fetch the guard name
    String roleName = 'Guard'; // Replace with the actual role check logic
    if (roleName == 'Guard') {
      guardName = (await _controller.fetchGuardName()) ?? '';
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    initializeControllerFuture = cameraController?.initialize();
  }

  Future<void> takePicture() async {
    try {
      await initializeControllerFuture;
      final picture = await cameraController!.takePicture();
      setState(() {
        _imageBytes = File(picture.path).readAsBytesSync();
      });
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _showSubmitSuccessDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Report has been successfully submitted!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrol Report'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Submit Your Patrol Report',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _messageController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _message = value,
              ),
              SizedBox(height: 20),
              _imageBytes != null
                  ? Image.memory(
                Uint8List.fromList(_imageBytes!),
                // Use Image.memory for Uint8List
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
                  : ElevatedButton(
                onPressed: takePicture,
                child: Text('Take Picture'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var report = PatrolReport(
                    GuardName: guardName,
                    message: _message,
                    imageBytes: _imageBytes,
                    timestamp: DateTime.now(),
                  );
                  await _controller.sendPatrolReport(report);
                  _showSubmitSuccessDialog();
                },
                child: Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PatrolReportView extends StatelessWidget {
  final PatrolReportController _patrolReportController = PatrolReportController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrol Reports'),
      ),
      body: StreamBuilder<List<PatrolReport>>(
        stream: _patrolReportController.getPatrolReports(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No patrol reports available.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              PatrolReport report = snapshot.data![index];
              return ListTile(
                title: Text(report.GuardName ?? 'Guard Name not available'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report.message ?? 'No message'),
                    if (report.imageBytes != null)
                      Image.memory(
                        report.imageBytes!, //as Uint8List,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    Text(
                      report.timestamp != null
                          ? 'Timestamp: ${report.timestamp!.toString()}'
                          : 'No timestamp',
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
