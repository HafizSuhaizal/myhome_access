/*
class PatrolScheduleModel {
  String? guardName;
  String? dayName;
  String? day;
  String? shift;
  String? startTime;

  PatrolScheduleModel({this.guardName, this.dayName, this.day, this.shift, this.startTime});

  factory PatrolScheduleModel.fromMap(Map<String, dynamic> map) {
    return PatrolScheduleModel(
        guardName: map['guardName'],
        dayName: map['dayName'],
        day: map['day'],
        shift: map['shift'],
        startTime: map['startTime'],
        );
    }
}
*/


class PatrolScheduleModel {
  String? id; // Add this line for the document ID
  String? guardName;
  String? dayName;
  String? day;
  String? shift;
  String? startTime;

  PatrolScheduleModel({this.id,this.guardName, this.dayName, this.day, this.shift, this.startTime});

  factory PatrolScheduleModel.fromMap(
String id,
Map<String, dynamic> map) {
    return PatrolScheduleModel(
      id: id, // Add this line to set the document ID
      guardName: map['guardName'],
      dayName: map['dayName'],
      day: map['day'],
      shift: map['shift'],
      startTime: map['startTime'],
    );
  }
}
