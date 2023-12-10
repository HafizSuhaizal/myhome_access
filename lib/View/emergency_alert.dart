import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../Controller/emergency_alert.dart';

class EmergencyScreen extends StatefulWidget {
  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final EmergencyController _controller = EmergencyController();
  CameraController? cameraController;
  Future<void>? initializeControllerFuture;

  String _type = '';
  String _message = '';
  String? _imageUrl;
  final _typeController = TextEditingController();
  final _messageController = TextEditingController();

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

  @override
  void dispose() {
    _typeController.dispose();
    _messageController.dispose();
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Alert'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Report an Emergency',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(
                labelText: 'Type of Emergency',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _type = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _messageController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
            SizedBox(height: 20),
            _imageUrl != null
                ? Image.file(File(_imageUrl!))
                : Container(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: takePicture,
                  child: Text('Take Picture'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    var alert = EmergencyAlert(
                      type: _type,
                      message: _message,
                      imageUrl: _imageUrl,
                      timestamp: DateTime.now(),
                    );
                    _controller.sendEmergencyAlert(alert);
                  },
                  child: Text('Send Alert'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
