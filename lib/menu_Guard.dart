import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhome_access/View/notification.dart';
import 'package:myhome_access/View/patrol_report.dart';
import 'package:myhome_access/View/patrol_schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';




class MainMenuGuard extends StatelessWidget {

  Future<void> myFunction() async {
    final prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // Retrieve user email from SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                String? userEmail = prefs.getString('userEmail');

                // Navigate to PatrolReportScreen with userEmail parameter
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatrolReportScreen(userEmail: userEmail!),
                  ),
                );
              },
              child: Text('Patrol Report'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Module 2
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              child: Text('Emergency Alert'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Module 3
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatrolScheduleScreen()),
                );
              },
              child: Text('Patrol Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class Module1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Module 1'),
      ),
      body: Center(
        child: Text('Content of Module 1'),
      ),
    );
  }
}

class Module2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Module 2'),
      ),
      body: Center(
        child: Text('Content of Module 2'),
      ),
    );
  }
}

class Module3Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Module 3'),
      ),
      body: Center(
        child: Text('Content of Module 3'),
      ),
    );
  }
}*/
