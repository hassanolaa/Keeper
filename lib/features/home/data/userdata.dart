import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        return doc.data();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<void> deleteUser() async {
  try {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      // Reference to the user document
      final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

      // Delete all documents in the 'bookmarks' subcollection
      final bookmarksSnapshot = await userRef.collection('bookmarks').get();
      for (final doc in bookmarksSnapshot.docs) {
       
        await doc.reference.delete();
        
      }

      // Delete all documents in the 'notes' subcollection
      final notesSnapshot = await userRef.collection('notes').get();
      for (final doc in notesSnapshot.docs) {
        await doc.reference.delete();
      }

      // Delete the user document itself
      await userRef.delete();

      // Delete the user from Firebase Authentication
      await FirebaseAuth.instance.currentUser?.delete();
    }
  } catch (e) {
    print('Error deleting user: $e');
  }
}
}
