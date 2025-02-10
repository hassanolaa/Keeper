import 'package:bloc/bloc.dart';
import 'package:bookmarker/features/Bookmark/data/user_bookmarks.dart';
import 'package:bookmarker/features/Note/data/user_notes.dart';
import 'package:meta/meta.dart';
import 'package:bookmarker/features/Add_marks_And_notes/data/addbookmark&note.dart';

part 'add_bookmark_note_state.dart';

class AddBookmarkNoteCubit extends Cubit<AddBookmarkNoteState> {
  AddBookmarkNoteCubit() : super(AddBookmarkNoteInitial());


  List<Map<String, dynamic>> categories = [];
  

  Future<void> fetchBookmarkCategories() async {
    try {
      emit(AddBookmarkNoteLoading());
      final categories_in = await AddBookmarkNote.getBookmarkCategories();
      if (categories_in != null) {
        categories = categories_in;
        emit(BookmarkCategoriesLoaded());
      } else {
        emit(AddBookmarkNoteError("Failed to load bookmark categories"));
      }
    } catch (e) {
      emit(AddBookmarkNoteError(e.toString()));
    }
  }

  Future<void> fetchNoteCategories() async {
    try {
      emit(AddBookmarkNoteLoading());
      final categories_in = await AddBookmarkNote.getNoteCategories();
      if (categories_in != null) {
        categories = categories_in;
        emit(NoteCategoriesLoaded());
      } else {
        emit(AddBookmarkNoteError("Failed to load note categories"));
      }
    } catch (e) {
      emit(AddBookmarkNoteError(e.toString()));
    }
  }

  Future<void> createBookmark(String category, String title, String url,String description) async {
    try {
      emit(AddBookmarkNoteLoading());
      await AddBookmarkNote.createBookmark(category, title, url,description);
      emit(BookmarkCreated());
    } catch (e) {
      emit(AddBookmarkNoteError(e.toString()));
    }
  }

  Future<void> createNote(String category, String title, String content) async {
    try {
      emit(AddBookmarkNoteLoading());
      await AddBookmarkNote.createNote(category, title, content);
      emit(NoteCreated());
    } catch (e) {
      emit(AddBookmarkNoteError(e.toString()));
    }
  }

  // add new bookmark category
  Future<void> addBookmarkCategory(String category, String color) async {
    try {
      emit(AddBookmarkNoteLoading());
      await UserBookmarks.addCategory(category, color);
      fetchBookmarkCategories();
      emit(AddCategoryLoaded());

    } catch (e) {
      emit(AddCategoryError(e.toString()));
    }
  }

  // add new note category
  Future<void> addNoteCategory(String category, String color) async {
    try {
      emit(AddBookmarkNoteLoading());
      await UserNotes.addCategory(category, color);
      fetchNoteCategories();
      emit(AddCategoryLoaded());

    } catch (e) {
      emit(AddCategoryError(e.toString()));
    }
  }
}
