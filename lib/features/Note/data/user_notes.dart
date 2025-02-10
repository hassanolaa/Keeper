import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserNotes {
  static Future<List<Map<String, dynamic>>?>
      getUserNotes_categories() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('notes')
            .get();
        
        return querySnapshot.docs.map((doc) => doc.data()).toList();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // add a new category
  static Future<void> addCategory(
      String category_name, String category_color) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('notes')
            .doc(category_name)
            .set({
          'category_name': category_name,
          'category_color': category_color,
          'notes_count': 0
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // get user notes from a category
  static Future<List<Map<String, dynamic>>?> getUserNotes(
      String category_name) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('notes')
            .doc(category_name)
            .collection('Notescategory')
            .get();
        return querySnapshot.docs.map((doc) => doc.data()).toList();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
