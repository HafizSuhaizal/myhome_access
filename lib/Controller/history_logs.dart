import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/history_logs.dart';

class HistoryLogsController {
  final HistoryLogsModel _model = HistoryLogsModel();

  Stream<List<HistoryLogsItem>> getEmergencyLogsStream() {
    return _model.getHistoryLogsStream('emergency_alerts');
  }

  Stream<List<HistoryLogsItem>> getVisitorLogsStream() {
    return _model.getHistoryLogsStream('visitor');
  }
}