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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _typeController,
              decoration: InputDecoration(
                labelText: 'Type of Emergency',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _type = value;
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _message = value;
              },
            ),
            SizedBox(height: 10),
            if (initializeControllerFuture != null)
              FutureBuilder<void>(
                future: initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(cameraController!);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            SizedBox(height: 20),
            FutureBuilder(
              future: _imageUrl == null ? Future.value(false) : File(_imageUrl!).exists(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == true) {
                    return Image.file(File(_imageUrl!));
                  } else {
                    return Text("No image selected.");
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: takePicture,
              child: Text('Take Picture'),
            ),
            SizedBox(height: 10),
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
      ),
    );
  }
}