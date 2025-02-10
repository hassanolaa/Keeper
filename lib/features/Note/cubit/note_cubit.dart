import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/user_notes.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> Notes = [];
  

   Future<void> fetchUserNotes_categories() async {
    try {
      emit(NoteLoading());
      final categories_in = await UserNotes.getUserNotes_categories();
      if (categories_in != null) {
        categories = categories_in;
        emit(NoteLoaded());
      } else {
        emit(NoteError("Failed to load Notes"));
      }
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  // add new category
  Future<void> addCategory(String category_name, String category_color) async {
    try {
      emit(AddCategoryLoading());
      await UserNotes.addCategory(category_name, category_color);
      fetchUserNotes_categories();
      emit(AddCategoryLoaded());
    } catch (e) {
      emit(AddCategoryError(e.toString()));
    }
  }

 // get notes of a category
  Future<void> getNotes(String category) async {
    try {
      emit(GetNotesLoading());
      final Notes_in = await UserNotes.getUserNotes(category);
      if (Notes_in != null) {
        Notes = Notes_in;
        emit(GetNotesLoaded());
      } else {
        emit(GetNotesError("There are no Notes in this category"));
      }
    } catch (e) {
      emit(GetNotesError(e.toString()));
    }
  }
}
