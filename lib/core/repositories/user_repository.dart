import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  static Future<void> createUserDocument(User user) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'id': user.uid,
        'isAnonumous': user.isAnonymous,
        'photoUrl': user.photoURL,
        'displayName': user.displayName,
        'email': user.email,
        'isEmailVerified': user.emailVerified,
      });
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<void> updateUserEmail(User user, String email) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'email': email});
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<void> deleteUserDocument(String id) async {
    try {
      final _fetchedMatches = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('matches')
          .get();

      for (DocumentSnapshot _matches in _fetchedMatches.docs) {
        _matches.reference.delete();
      }

      final _fetchedContests = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('contests')
          .get();

      for (DocumentSnapshot _contests in _fetchedContests.docs) {
        _contests.reference.delete();
      }

      await FirebaseFirestore.instance.collection('users').doc(id).delete();
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<bool> doesUserExists(String id) async {
    try {
      final _registeredUsers = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: id)
          .get();

      return _registeredUsers.docs.isNotEmpty;
    } catch (error) {
      throw Exception(error);
    }
  }
}
