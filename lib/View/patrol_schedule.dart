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


/*import 'package:flutter/material.dart';
import '../Controller/patrol_schedule.dart';
import '../Model/patrol_schedule.dart';

class PatrolScheduleView extends StatefulWidget {
  @override
  _PatrolScheduleViewState createState() => _PatrolScheduleViewState();
}

class _PatrolScheduleViewState extends State<PatrolScheduleView> {
  final _controller = PatrolScheduleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrol Schedules'),
      ),
      body: FutureBuilder<List<PatrolScheduleModel>>(
        future: _controller.getAllPatrolSchedules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final schedules = snapshot.data;

            if (schedules == null || schedules.isEmpty) {
              return Text('No patrol schedules available.');
            }

            return ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                return ListTile(
                  title: Text(schedule.email),
                  subtitle: Text('Schedule: ${schedule.schedule}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import '../Controller/patrol_schedule.dart';
import '../Model/patrol_schedule.dart'; // Import the controller

class PatrolScheduleView extends StatefulWidget {
  @override
  _PatrolScheduleViewState createState() => _PatrolScheduleViewState();
}

class _PatrolScheduleViewState extends State<PatrolScheduleView> {
  late Future<List<PatrolScheduleModel>> _patrolSchedulesFuture;
  late PatrolScheduleController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PatrolScheduleController();

    // Uncomment either of the following lines based on your use case:
    // 1. To fetch existing patrol schedules
    _patrolSchedulesFuture = _fetchPatrolSchedules();

    // 2. To generate new patrol schedules
    // _patrolSchedulesFuture = _generatePatrolSchedule();
  }

  Future<List<PatrolScheduleModel>> _fetchPatrolSchedules() async {
    return _controller.getAllPatrolSchedules();
  }

  Future<List<PatrolScheduleModel>> _generatePatrolSchedule() async {
    await _controller.generatePatrolSchedule();
    return _controller.getAllPatrolSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrol Schedules'),
      ),
      body: FutureBuilder<List<PatrolScheduleModel>>(
        future: _patrolSchedulesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No patrol schedules available.');
          } else {
            return _buildListView(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildListView(List<PatrolScheduleModel> patrolSchedules) {
    return ListView.builder(
      itemCount: patrolSchedules.length,
      itemBuilder: (context, index) {
        final schedule = patrolSchedules[index];

        return ListTile(
          title: Text('Email: ${schedule.email}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Schedule:'),
              for (final shift in schedule.schedule)
                Text('   ${shift['day']}: ${shift['shifts']}'),
            ],
          ),
        );
      },
    );
  }
}


