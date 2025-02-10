part of 'add_bookmark_note_cubit.dart';

@immutable
sealed class AddBookmarkNoteState {}

final class AddBookmarkNoteInitial extends AddBookmarkNoteState {}

final class AddBookmarkNoteLoading extends AddBookmarkNoteState {}

final class BookmarkCategoriesLoaded extends AddBookmarkNoteState {
  BookmarkCategoriesLoaded();
}

final class NoteCategoriesLoaded extends AddBookmarkNoteState {
  NoteCategoriesLoaded();
}

final class BookmarkCreated extends AddBookmarkNoteState {}

final class NoteCreated extends AddBookmarkNoteState {}

final class AddBookmarkNoteError extends AddBookmarkNoteState {
  final String message;
  AddBookmarkNoteError(this.message);
}

// add category
final class AddCategoryLoaded extends AddBookmarkNoteState {
  
  AddCategoryLoaded();
}


// add category error
final class AddCategoryError extends AddBookmarkNoteState {
  final String message;
  AddCategoryError(this.message);
}



