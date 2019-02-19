import 'package:redux/redux.dart';
import 'package:wm_library_app/model/book.dart';

final BookReducer = combineReducers<List<Book>>([
  TypedReducer<List<Book>, GetBookAction>(_get),
]);

List<Book> _get(List<Book> list, action) {
  list.clear();
  if (action.list == null) {
    return list;
  } else {
    list.addAll(action.list);
    return list;
  }
}


class GetBookAction {
  final List<Book> list;

  GetBookAction(this.list);
}