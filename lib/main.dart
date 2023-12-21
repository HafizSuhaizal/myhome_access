import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myhome_access/View/history_logs.dart';
import 'View/emergency_alert.dart';
import 'View/fine_visitor_vehicle.dart';
import 'package:myhome_access/View/emergency_alert.dart';
import 'package:myhome_access/View/notification.dart';
import 'package:myhome_access/View/visitor_vehicle.dart';
import 'package:myhome_access/View/login_screen.dart';
import 'package:myhome_access/signup_screen.dart';
import 'package:myhome_access/vehicle.dart';
import 'View/patrol_report.dart';
import 'View/patrol_schedule.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'View/user.dart';
import 'View/vehicle_view.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //home:EmergencyScreen(),

      //home:LoginScreen(),
      //home:SignUpScreen(),

        //home: PatrolReportView() ,
      //home: PatrolReportScreen(userEmail: '',),
      //home: HistoryLogsView(),


      home: LoginScreen(),

      //home: PatrolReportScreen(userEmail: '',),

    );
  }
}