import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'View/emergency_alert.dart';
import 'View/fine_visitor_vehicle.dart';
import 'View/user.dart';
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

