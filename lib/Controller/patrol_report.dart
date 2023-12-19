/*

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatrolReportController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendPatrolReport(PatrolReport report) async {
    await _firestore.collection('patrol_report').add({
      'message': report.message,
      'imageUrl': report.imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

class PatrolReport {
  String? id; // Made nullable
  String message;
  String? imageUrl; // Made nullable
  DateTime? timestamp; // Made nullable
  PatrolReport({this.id, required this.message, this.imageUrl, this.timestamp});
}
*/


import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../Model/patrol_report.dart';

class PatrolReportController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /*Future<void> sendPatrolReport(PatrolReport report) async {
    await _firestore.collection('patrol_report').add({
      'Name': report.GuardName,
      'message': report.message,
      'imageUrl': report.imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }*/

  /*Future<void> sendPatrolReport(PatrolReport report) async {
    // Convert the image to bytes
    Uint8List? imageBytes;
    if (report.imageBytes != null) {
      final ByteData data = await rootBundle.load(report.imageBytes as String);
      imageBytes = data.buffer.asUint8List();
    }
    await _firestore.collection('patrol_report').add({
      'GuardName': report.GuardName,
      'message': report.message,
      'imageBytes': imageBytes,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
*/
  Stream<List<PatrolReport>> getPatrolReports() {
    return _firestore
        .collection('patrol_report')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // Check if 'imageBytes' field exists and is not null
        if (doc.data()?['imageBytes'] != null) {
          return PatrolReport.fromMap(
            doc.data()..['imageBytes'] = base64Decode(doc.data()?['imageBytes']),
            doc.id,
          );
        } else {
          return PatrolReport.fromMap(doc.data(), doc.id);
        }
      }).toList();
    });
  }



  Future<void> sendPatrolReport(PatrolReport report) async {
    // Convert the image to bytes
    String? imageBytes = base64Encode(report.imageBytes as List<int>);

    await _firestore.collection('patrol_report').add({
      'GuardName': report.GuardName,
      'message': report.message,
      'imageBytes': imageBytes,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }



  Future<String?> fetchGuardName() async {
    try {
      // Get the current user
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch the user document from Firestore using email as the identifier
        var docSnapshot = await FirebaseFirestore.instance.collection('users')
            .where('email', isEqualTo: user.email)
            .get();

        // Check if the document exists
        if (docSnapshot.docs.isNotEmpty) {
          // Extract user data from the first document in the query result
          Map<String, dynamic> data = docSnapshot.docs.first.data() as Map<
              String,
              dynamic>;

          // Return the name field, or null if it doesn't exist
          return data['name'] as String?;
        } else {
          print("Document does not exist");
          return null;
        }
      } else {
        // No user is logged in
        print("No user logged in");
        return null;
      }
    } catch (e) {
      // Handle errors (e.g., network issues, permission denied)
      print("Error fetching user name: $e");
      return null;
    }
  }
}