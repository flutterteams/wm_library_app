import 'package:redux/redux.dart';
import 'package:wm_library_app/model/book.dart';

final BookReducer = combineReducers<Map>([
  TypedReducer<Map, GetBookAction>(_get),
  TypedReducer<Map, GetBookAddListAction>(_getAddList),
  TypedReducer<Map, GetBookListAction>(_getList),
]);

Map _get(Map map, action) {
  if (action.map == null) {
    return map;
  } else {
    map.addAll(action.map);
    return map;
  }
}

Map _getAddList(Map map, action) {

  if (action.list == null) {
    return map;
  } else {
    List<Book> list = map.containsKey('list') ? map['list'] : [];
    list.addAll(action.list);
    map['list'] = list;
    return map;
  }
}

Map _getList(Map map, action) {
  if (action.list == null) {
    return map;
  } else {
    List<Book> list = map.containsKey('list') ? map['list'] : [];
    list = action.list;
    map['list'] = list;
    return map;
  }
}


class GetBookAction {
  final Map map;

  GetBookAction(this.map);
}


class GetBookListAction {
  final List<Book> list;

  GetBookListAction(this.list);
}

class GetBookAddListAction {
  final List<Book> list;

  GetBookAddListAction(this.list);
}