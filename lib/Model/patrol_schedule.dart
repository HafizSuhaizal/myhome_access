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
