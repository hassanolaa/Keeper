import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBookmarks {
  static Future<List<Map<String, dynamic>>?>
      getUserBookmarks_categories() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('bookmarks')
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
            .collection('bookmarks')
            .doc(category_name)
            .set({
          'category_name': category_name,
          'category_color': category_color,
          'bookmarks_count': 0
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // get the bookmarks of a category
  static Future<List<Map<String, dynamic>>?> getBookmarks(String category) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('bookmarks')
            .doc(category)
            .collection('Bookmarkscategory')
            .get();
        return querySnapshot.docs.map((doc) => doc.data()).toList();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

}
