import 'package:bloc/bloc.dart';
import 'package:bookmarker/features/Bookmark/data/user_bookmarks.dart';
import 'package:bookmarker/features/Note/data/user_notes.dart';
import 'package:meta/meta.dart';
import 'package:bookmarker/features/home/data/userdata.dart';

import '../../Add_marks_And_notes/data/addbookmark&note.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Map<String, dynamic> userData = {};
  List<Map<String, dynamic>> Bookmarks_categories = [];
  List<Map<String, dynamic>> notes_categories = [];
  List<Map<String, dynamic>> Bookmarks_list = [];
  List<Map<String, dynamic>> Notes_list = [];

  bool Bookmarks = true;
  bool view = true;

  setview_true() {
    view = true;
    emit(UserLoaded());
  }

  setview_false() {
    view = false;
    emit(UserLoaded());
  }

  // switching between bookmarks and notes
  void switchBookmarks() {
    Bookmarks = !Bookmarks;
    emit(UserLoaded());
  }

  Future<void> fetchUserData() async {
    try {
      emit(UserLoading());
      final userData_in = await UserData.getUserData();
      if (userData_in != null) {
        userData = userData_in;
        emit(UserLoaded());
      } else {
        emit(UserError("Failed to load user data"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  // delete the user
  Future<void> deleteUser() async {
    try {
      emit(UserLoading());
      await UserData.deleteUser();
      emit(UserDeleted());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  // get user bookmarks
  Future<void> getUserBookmarks_categories() async {
    try {
      emit(UserLoading());
      final notes_in = await UserBookmarks.getUserBookmarks_categories();
      if (notes_in != null) {
        Bookmarks_categories = notes_in;
        getBookmarks(Bookmarks_categories[0]['category_name']);
        emit(UserLoaded());
      } else {
        emit(UserError("Failed to load user bookmarks"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  // get bookmarks by category name
  Future<void> getBookmarks(String category) async {
    try {
      emit(UserLoading());
      final notes_in = await UserBookmarks.getBookmarks(category);
      if (notes_in != null) {
        Bookmarks_list = notes_in;
        emit(UserLoaded());
      } else {
        emit(UserError("Failed to load user bookmarks"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  // addBookmarkCategory
  Future<void> addBookmarkCategory(String category_name, String color) async {
    try {
      emit(UserLoading());
      await UserBookmarks.addCategory(category_name, color);
      getUserBookmarks_categories();
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  // create bookmark
  Future<void> createBookmark(
      String category, String title, String url, String description) async {
    try {
      emit(UserLoading());
      await AddBookmarkNote.createBookmark(category, title, url, description);
      emit(UserLoaded());
      emit(BookmarkCreated());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  // get user notes
  Future<void> getUserNotes_categories() async {
    try {
      emit(UserLoading());
      final notes_in = await UserNotes.getUserNotes_categories();
      if (notes_in != null) {
        notes_categories = notes_in;
        getNotes(notes_categories[0]['category_name']);
        emit(UserLoaded());
      } else {
        emit(UserError("Failed to load user bookmarks"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

// get notes by category name
  Future<void> getNotes(String category) async {
    try {
      emit(UserLoading());
      final notes_in = await UserNotes.getUserNotes(category);
      if (notes_in != null) {
        Notes_list = notes_in;
        emit(UserLoaded());
      } else {
        emit(UserError("Failed to load user bookmarks"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

// create Note
  Future<void> createNote(String category, String title, String content) async {
    try {
      emit(UserLoading());
      await AddBookmarkNote.createNote(category, title, content);
      emit(UserLoaded());
      emit(NoteCreated());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

// add new category
  Future<void> addNoteCategory(
      String category_name, String category_color) async {
    try {
      emit(UserLoading());
      await UserNotes.addCategory(category_name, category_color);
      getUserNotes_categories();
      emit(UserLoaded());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
