/*
class EmergencyAlert {
  String? id; // Made nullable
  String GuardName;
  String message;
  String? imageUrl; // Made nullable
  DateTime? timestamp; // Made nullable

  EmergencyAlert({this.id, required this.GuardName, required this.message, this.imageUrl, this.timestamp});
*/

  /*import 'package:cloud_firestore/cloud_firestore.dart';

class PatrolReport {
  String? id;
  String message;
  String? imageUrl;
  DateTime? timestamp;
  String GuardName;

  PatrolReport({this.id, required this.message, this.imageUrl, this.timestamp, required this.GuardName});

  factory PatrolReport.fromMap(Map<String, dynamic> map, String id) {
  return PatrolReport(
  id: id,
  message: map['message'],
  imageUrl: map['imageUrl'],
  timestamp: (map['timestamp'] as Timestamp?)?.toDate(),
    GuardName: map ['GuardName'],
  );
  }
  }
*/

import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

/*class PatrolReport {
  String? id;
  String? message;
  String? imageUrl;
  DateTime? timestamp;
  String? GuardName;

  PatrolReport({this.id, this.message, this.imageUrl, this.timestamp, this.GuardName});

  factory PatrolReport.fromMap(Map<String, dynamic> map, String id) {
    return PatrolReport(
      id: id,
      message: map['message'] as String?,
      imageUrl: map['imageUrl'] as String?,
      timestamp: (map['timestamp'] as Timestamp?)?.toDate(),
      GuardName: map['Name'] as String?,
    );
  }
}*/

/*class PatrolReport {
  String? id;
  String? message;
  Uint8List? imageBytes; // Change from String to Uint8List
  DateTime? timestamp;
  String? GuardName;

  PatrolReport({this.id, this.message, this.imageBytes, this.timestamp, this.GuardName});

  factory PatrolReport.fromMap(Map<String, dynamic> map, String id) {
    return PatrolReport(
      id: id,
      message: map['message'] as String?,
      imageBytes: map['imageBytes'] as Uint8List?,
      timestamp: (map['timestamp'] as Timestamp?)?.toDate(),
      GuardName: map['GuardName'] as String?,
    );
  }
}*/


class PatrolReport {
  String? id;
  String? message;
  Uint8List? imageBytes; // Change from String to Uint8List
  DateTime? timestamp;
  String? GuardName;

  PatrolReport({this.id, this.message, this.imageBytes, this.timestamp, this.GuardName});

  factory PatrolReport.fromMap(Map<String, dynamic> map, String id) {
    return PatrolReport(
      id: id,
      message: map['message'] as String?,
      // Decode the base64-encoded imageBytes if it's a String
      imageBytes: _decodeImageBytes(map['imageBytes']),
      timestamp: (map['timestamp'] as Timestamp?)?.toDate(),
      GuardName: map['GuardName'] as String?,
    );
  }

  static Uint8List? _decodeImageBytes(dynamic value) {
    if (value is String) {
      return base64Decode(value);
    } else if (value is Uint8List) {
      return value;
    }
    return null;
  }
}


