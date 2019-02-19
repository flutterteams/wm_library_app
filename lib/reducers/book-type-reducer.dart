import 'package:redux/redux.dart';
import 'package:wm_library_app/model/book_type.dart';

final BookTypeReducer = combineReducers<List<BookType>>([
  TypedReducer<List<BookType>, GetBookTypeAction>(_get),
]);

List<BookType> _get(List<BookType> list, action) {
  list.clear();
  if (action.list == null) {
    return list;
  } else {
    list.addAll(action.list);
    return list;
  }
}


class GetBookTypeAction {
  final List<BookType> list;

  GetBookTypeAction(this.list);
}