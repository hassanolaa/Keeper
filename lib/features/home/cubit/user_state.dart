part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  UserLoaded();
}

final class UserError extends UserState {
  final String message;
  UserError(this.message);
}

final class UserDeleted extends UserState {}

final class BookmarkCreated extends UserState {}

final class NoteCreated extends UserState {}