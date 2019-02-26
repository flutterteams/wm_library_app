import 'package:redux/redux.dart';
import 'package:wm_library_app/model/person.dart';

final PersonReducer = combineReducers<List<Person>>([
  TypedReducer<List<Person>, GetPersonAction>(_getPersonList),
]);

List<Person> _getPersonList(List<Person> list, action) {
  list.clear();
  if (action.list == null) {
    return list;
  } else {
    list.addAll(action.list);
    return list;
  }
}

class GetPersonAction {
  final List<Person> list;

  GetPersonAction(this.list);
}
