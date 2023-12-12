class PatrolScheduleModel {
  String? guardName;
  String? day;
  String? shift;
  String? startTime;

  PatrolScheduleModel({this.guardName, this.day, this.shift, this.startTime});

  factory PatrolScheduleModel.fromMap(Map<String, dynamic> map) {
    return PatrolScheduleModel(
      guardName: map['guardName'],
      day: map['day'],
      shift: map['shift'],
      startTime: map['startTime'],
    );
  }
}
