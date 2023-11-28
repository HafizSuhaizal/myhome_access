class Schedule {
  String scheduleId;
  String guardId;
  DateTime date;
  String shift; // e.g., 'morning', 'evening'

  Schedule({required this.scheduleId, required this.guardId, required this.date, required this.shift});

  factory Schedule.fromMap(Map<String, dynamic> data) {
    return Schedule(
      scheduleId: data['scheduleId'],
      guardId: data['guardId'],
      date: DateTime.parse(data['date']),
      shift: data['shift'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'scheduleId': scheduleId,
      'guardId': guardId,
      'date': date.toIso8601String(),
      'shift': shift,
    };
  }
}
