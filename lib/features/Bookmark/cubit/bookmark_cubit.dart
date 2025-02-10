import 'package:bloc/bloc.dart';
import 'package:bookmarker/features/Bookmark/ui/widgets/category.dart';
import 'package:meta/meta.dart';
import 'package:bookmarker/features/Bookmark/data/user_bookmarks.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());

  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> bookmarks = [];

  Future<void> fetchUserBookmarks_categories() async {
    try {
      emit(BookmarkLoading());
      final categories_in = await UserBookmarks.getUserBookmarks_categories();
      if (categories_in != null) {
        categories = categories_in;
        emit(BookmarkLoaded());
      } else {
        emit(BookmarkError("Failed to load bookmarks"));
      }
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  // add new category
  Future<void> addCategory(String category_name, String category_color) async {
    try {
      emit(AddCategoryLoading());
      await UserBookmarks.addCategory(category_name, category_color);
      fetchUserBookmarks_categories();
      emit(AddCategoryLoaded());
    } catch (e) {
      emit(AddCategoryError(e.toString()));
    }
  }

  // get bookmarks of a category
  Future<void> getBookmarks(String category) async {
    try {
      emit(GetBookmarksLoading());
      final bookmarks_in = await UserBookmarks.getBookmarks(category);
      if (bookmarks_in != null) {
        bookmarks = bookmarks_in;
        emit(GetBookmarksLoaded());
      } else {
        emit(GetBookmarksError("There are no bookmarks in this category"));
      }
    } catch (e) {
      emit(GetBookmarksError(e.toString()));
    }
  }


}
