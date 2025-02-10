import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit() : super(BookmarksInitial());
}
