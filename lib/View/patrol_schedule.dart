/*
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
      body: FutureBuilder<List<String>>(
        future: _controller.getGuardNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Guard names available'));
          }

          List<String> guardNames = snapshot.data!;

          return StreamBuilder<List<PatrolScheduleModel>>(
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
                    trailing: DropdownButton<String>(
                      value: schedule[index].guardName,
                      onChanged: (String? newGuardName) async {
                        if (newGuardName != null) {
                          await _controller.updatePatrolScheduleGuard(schedule[index].id!, newGuardName);
                          // You might want to refresh the schedule after the update
                          // For simplicity, you can rebuild the widget
                        }
                      },
                      items: guardNames
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
*/


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
      body: FutureBuilder<List<String>>(
        future: _controller.getGuardNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Guard names available'));
          }

          List<String> guardNames = snapshot.data!;

          return StreamBuilder<List<PatrolScheduleModel>>(
            stream: _controller.getPatrolSchedule(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData) {
                return Center(child: Text('No Patrol Schedule available'));
              }

              List<PatrolScheduleModel> schedule = snapshot.data!;

              return SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          // DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Shift')),
                          DataColumn(label: Text('Start Time')),
                          DataColumn(label: Text('Guard')),
                        ],
                        rows: schedule.map((entry) {
                          return DataRow(cells: [
                            // DataCell(Text(entry.guardName ?? '')),
                            DataCell(Text('${entry.dayName}, ${entry.day}')),
                            DataCell(Text(entry.shift ?? '')),
                            DataCell(Text(entry.startTime ?? '')),
                            DataCell(
                              DropdownButton<String>(
                                value: entry.guardName,
                                onChanged: (String? newGuardName) async {
                                  if (newGuardName != null) {
                                    await _controller.updatePatrolScheduleGuard(entry.id!, newGuardName);
                                    // You might want to refresh the schedule after the update
                                    // For simplicity, you can rebuild the widget
                                  }
                                },
                                items: guardNames
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
