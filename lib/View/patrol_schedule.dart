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

class PatrolScheduleScreen extends StatelessWidget {
  final PatrolScheduleController _controller = PatrolScheduleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrol Schedule'),
      ),
      body: StreamBuilder<List<PatrolScheduleModel>>(
        stream: _controller.getPatrolSchedule(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No Patrol Schedule available'));
          }

          List<PatrolScheduleModel> schedule = snapshot.data!;

          return ListView.builder(
            itemCount: schedule.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(schedule[index].guardName ?? ''),
                subtitle: Text('${schedule[index].dayName}, ${schedule[index].day} - ${schedule[index].shift} - ${schedule[index].startTime}'),
              );
            },
          );
        },
      ),
    );
  }
}
