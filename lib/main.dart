import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myhome_access/View/emergency_alert.dart';
import 'package:myhome_access/View/visitor_vehicle.dart';
import 'package:myhome_access/login_screen.dart';
import 'package:myhome_access/signup_screen.dart';
import 'package:myhome_access/vehicle.dart';
import 'View/vehicle_view.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:EmergencyScreen(),
    );
  }
}

