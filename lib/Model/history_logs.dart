import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryLogsItem {
  String id; // Made non-nullable
  String type;
  String message;
  String? imageUrl;
  DateTime? timestamp;
  DateTime? accessStartTime;
  DateTime? accessEndTime;
  String? plateNumber;
  String? status;
  String? typeOfAccess;
  String? vehicleType;
  String? visitorName;

  HistoryLogsItem({
    required this.id,
    required this.type,
    required this.message,
    this.imageUrl,
    this.timestamp,
    this.accessStartTime,
    this.accessEndTime,
    this.plateNumber,
    this.status,
    this.typeOfAccess,
    this.vehicleType,
    this.visitorName,
  });

  factory HistoryLogsItem.fromMap(Map<String, dynamic> map) {
    return HistoryLogsItem(
      id: map['id'] ?? '', // Ensure 'id' is non-nullable
      type: map['type'] ?? '',
      message: map['message'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      timestamp: map['timestamp']?.toDate(),
      accessStartTime: map['accessStartTime']?.toDate(),
      accessEndTime: map['accessEndTime']?.toDate(),
      plateNumber: map['plateNumber'] ?? '',
      status: map['status'] ?? '',
      typeOfAccess: map['typeOfAccess'] ?? '',
      vehicleType: map['vehicleType'] ?? '',
      visitorName: map['visitorName'] ?? '',
    );
  }
}



class HistoryLogsModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<HistoryLogsItem>> getHistoryLogsStream(String collection) {
    return _firestore.collection(collection).snapshots().map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => HistoryLogsItem.fromMap({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        }),
      )
          .toList(),
    );
  }
}
