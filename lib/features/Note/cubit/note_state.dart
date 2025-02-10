part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}


final class NoteLoading extends NoteState {}

final class NoteLoaded extends NoteState {
  NoteLoaded();
}

final class NoteError extends NoteState {
  final String message;
  NoteError(this.message);
}


// add category loading
final class AddCategoryLoading extends NoteState {}

// add category loaded
final class AddCategoryLoaded extends NoteState {}

// add category error
final class AddCategoryError extends NoteState {
  final String message;
  AddCategoryError(this.message);
}


// get notes loading
final class GetNotesLoading extends NoteState {}

// get notes loaded
final class GetNotesLoaded extends NoteState {
  GetNotesLoaded();
}

// get notes error
final class GetNotesError extends NoteState {
  final String message;
  GetNotesError(this.message);
}