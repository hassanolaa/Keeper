import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddBookmarkNote {
  // Get bookmark categories from Firebase
  static Future<List<Map<String, dynamic>>?> getBookmarkCategories() async {
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

  // Get note categories from Firebase
  static Future<List<Map<String, dynamic>>?> getNoteCategories() async {
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

  // Create a new bookmark
  static Future<void> createBookmark(String category, String title, String url ,String description) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('bookmarks').doc(category).collection('Bookmarkscategory')
            .add({
          'category': category,
          'title': title,
          'url': url,
          'description': description,
          'created_at': FieldValue.serverTimestamp(),
        });



        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('bookmarks').doc(category)
          .set({
         'bookmarks_count': FieldValue.increment(1), // increment the bookmarks_count by 1
        }, SetOptions(merge: true));  // keep the existing fields in the document as they are       
        
      }
    } catch (e) {
      print(e);
    }
  }

  // Create a new note
  static Future<void> createNote(String category, String title, String content) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('notes').doc(category).collection('Notescategory')
            .add({
          'category': category,
          'title': title,
          'content': content,
          'created_at': FieldValue.serverTimestamp(),
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('notes').doc(category)
          .set({
         'notes_count': FieldValue.increment(1), // increment the notes_count by 1
        }, SetOptions(merge: true));  // keep the existing fields in the document as they are
      }
    } catch (e) {
      print(e);
    }
  }


}