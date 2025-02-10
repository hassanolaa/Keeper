part of 'bookmark_cubit.dart';

@immutable
sealed class BookmarkState {}

final class BookmarkInitial extends BookmarkState {}

final class BookmarkLoading extends BookmarkState {}

final class BookmarkLoaded extends BookmarkState {
  BookmarkLoaded();
}

final class BookmarkError extends BookmarkState {
  final String message;
  BookmarkError(this.message);
}

// add category loading
final class AddCategoryLoading extends BookmarkState {}

// add category loaded
final class AddCategoryLoaded extends BookmarkState {}

// add category error
final class AddCategoryError extends BookmarkState {
  final String message;
  AddCategoryError(this.message);
}

// get bookmarks loading
final class GetBookmarksLoading extends BookmarkState {}

// get bookmarks loaded
final class GetBookmarksLoaded extends BookmarkState {
  GetBookmarksLoaded();
}

// get bookmarks error
final class GetBookmarksError extends BookmarkState {
  final String message;
  GetBookmarksError(this.message);
}
