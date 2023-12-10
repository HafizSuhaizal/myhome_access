/*import 'package:flutter/material.dart';
import '../Controller/patrol_schedule.dart';

class PatrolSchedule extends StatefulWidget {
  const PatrolSchedule({super.key});

  @override
  State<PatrolSchedule> createState() => _PatrolScheduleState();
}

class _PatrolScheduleState extends State<PatrolSchedule> {
  final PatrolScheduleController controller = PatrolScheduleController();
  final TextEditingController guardNameController = TextEditingController();
  //final TextEditingController dateController = TextEditingController();
  DateTime selectedStartTime = DateTime.now();
  DateTime selectedEndTime = DateTime.now().add(Duration(hours: 2));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: guardNameController,
              decoration: InputDecoration(labelText: 'Guard Name'),
            ),
            /*TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Duty Date'),
            ),*/
            ListTile(
              title: Text("Start Time: ${selectedStartTime.toIso8601String()}"),
              onTap: () async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: selectedStartTime,
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                  if (date != null) {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(selectedStartTime),
                    );
                    if (time != null) {
                      setState(() {
                        selectedStartTime = DateTime(
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
              title: Text("End Time: ${selectedEndTime.toIso8601String()}"),
              onTap: () async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: selectedEndTime,
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (date != null) {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(selectedEndTime),
                  );
                  if (time != null) {
                    setState(() {
                      selectedEndTime = DateTime(
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
            ElevatedButton(
              onPressed: () async {
                try {
                  String result = await controller.addSchedule(
                    guardNameController.text,
                    selectedStartTime,
                    selectedEndTime,
                  );
                  _showDialog(context, result);
                } catch (e) {
                 _showDialog(context, 'Error: ${e.toString()}');
                };
              },
              child: Text('SUBMIT'),
            ),
          ]
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
}*/




// view.dart
/*import 'package:flutter/material.dart';
import '../Controller/patrol_schedule.dart';

class PatrolView extends StatelessWidget {
  final PatrolController controller = PatrolController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firebase Cloud Function Demo'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await controller.generateRandomPatrolSchedule();
            },
            child: Text('Generate Random Patrol Schedule'),
          ),
        ),
      ),
    );
  }
}*/


import 'package:flutter/material.dart';

import '../Controller/patrol_schedule.dart';
import '../Model/patrol_schedule.dart';


class PatrolScheduleView extends StatefulWidget {
  const PatrolScheduleView({Key? key}) : super(key: key);

  @override
  State<PatrolScheduleView> createState() => _PatrolScheduleViewState();
}

class _PatrolScheduleViewState extends State<PatrolScheduleView> {
  final PatrolScheduleController _scheduleController = PatrolScheduleController();

  @override
  Widget build(BuildContext context) {
    // Your UI for displaying and managing the patrol schedule goes here
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrol Schedule'),
      ),
      body: FutureBuilder(
        future: _scheduleController.getAllPatrolSchedules(),
        builder: (context, AsyncSnapshot<List<PatrolScheduleModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Display your list of patrol schedules using snapshot.data
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final schedule = snapshot.data![index];
                // Build your UI for each patrol schedule item
                return ListTile(
                  title: Text(schedule.day),
                  // Customize the display based on your PatrolScheduleModel structure
                );
              },
            );
          }
        },
      ),
    );
  }
}
