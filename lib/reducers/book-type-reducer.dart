import 'package:redux/redux.dart';
import 'package:wm_library_app/model/book_type.dart';

final BookTypeReducer = combineReducers<Map>([
  TypedReducer<Map, GetBookTypeAction>(_get),
]);

Map _get(Map map, action) {

  if (action.list == null) {
    return map;
  } else {
    Map typeMap = new Map();

    for(int i = 0; i < action.list.length; i++){
      typeMap[action.list[i].id] = action.list[i].name;
    }
    return typeMap;
  }
}


class GetBookTypeAction {
  final List<BookType> list;

  GetBookTypeAction(this.list);
}