import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/patrol_schedule.dart';

/*class PatrolScheduleController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<PatrolScheduleModel>> getPatrolSchedule() {
    return _firestore.collection('patrolSchedule').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PatrolScheduleModel.fromMap(doc.data())).toList();
      });
    }
}*/


class PatrolScheduleController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<PatrolScheduleModel>> getPatrolSchedule() {
    return _firestore.collection('patrolSchedule').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) =>
          PatrolScheduleModel.fromMap(doc.id, doc.data())).toList();
    });
  }


  Future<List<String>> getGuardNames() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users')
          .where('role', isEqualTo: 'Guard')
          .get();

      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      print('Error fetching guard names: $e');
      return [];
    }
  }


  Future<void> updatePatrolScheduleGuard(String documentId ,
      String newGuardName) async {
    try {
      await _firestore.collection('patrolSchedule').doc(documentId).update({
        'guardName': newGuardName,
      });
      print('Patrol schedule updated successfully!');
    } catch (e) {
      print('Error updating patrol schedule: $e');
      // Handle the error as needed
    }
  }

  Future<String?> fetchUserName() async {
    try {
      // Get the current user
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch the user document from Firestore using email as the identifier
        var docSnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get();

        // Check if the document exists
        if (docSnapshot.docs.isNotEmpty) {
          // Extract user data from the first document in the query result
          Map<String, dynamic> data = docSnapshot.docs.first.data() as Map<String, dynamic>;

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

