import 'package:redux/redux.dart';
import 'package:wm_library_app/model/borrow.dart';

final BorrowReducer = combineReducers<List<Borrow>>([
  TypedReducer<List<Borrow>, GetBorrowAction>(_get),
]);

List<Borrow> _get(List<Borrow> list, action) {
  list.clear();
  if (action.list == null) {
    return list;
  } else {
    list.addAll(action.list);
    return list;
  }
}

class GetBorrowAction {
  final List<Borrow> list;

  GetBorrowAction(this.list);
}
