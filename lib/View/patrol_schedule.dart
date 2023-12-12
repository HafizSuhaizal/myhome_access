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
