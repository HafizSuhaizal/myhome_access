import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../Controller/patrol_report.dart';

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

  String _message = '';
  String? _imageUrl;

  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initCamera();
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
        _imageUrl = picture.path;
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
              _imageUrl != null
                  ? Image.file(File(_imageUrl!))
                  : ElevatedButton(
                onPressed: takePicture,
                child: Text('Take Picture'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var alert = PatrolReport(
                    message: _message,
                    imageUrl: _imageUrl,
                    timestamp: DateTime.now(),
                  );
                  await _controller.sendPatrolReport(alert);
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
