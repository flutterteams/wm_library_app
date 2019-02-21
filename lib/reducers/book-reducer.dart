import 'package:redux/redux.dart';
import 'package:wm_library_app/model/book.dart';

final BookReducer = combineReducers<List<Book>>([
  TypedReducer<List<Book>, GetBookAction>(_get),
]);

List<Book> _get(List<Book> list, action) {
//  list.clear();
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

//final BookReducer = combineReducers<Map>([
//  TypedReducer<Map, GetBookAction>(_get),
//  TypedReducer<Map, GetBookListAction>(_getList),
//]);
//
//Map _get(Map map, action) {
////  list.clear();
//  if (action.map == null) {
//    return map;
//  } else {
//    map.addAll(action.map);
//    return map;
//  }
//}
//
//Map _getList(Map map, action) {
//
//  if (action.list == null) {
//    return map;
//  } else {
//    List list = map.containsKey('list') ? [] : map['list'];
//    list.addAll(action.list);
//    map['list'] = list;
//    return map;
//  }
//}
//
//
//class GetBookAction {
//  final Map map;
//
//  GetBookAction(this.map);
//}
//
//
//class GetBookListAction {
//  final List<Book> list;
//
//  GetBookListAction(this.list);
//}