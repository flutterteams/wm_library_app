

import 'package:redux/redux.dart';
import 'package:wm_library_app/model/login_user.dart';

final LoginReducer = combineReducers<List<LoginUser>>([
  TypedReducer<List<LoginUser>, GetLoginAction>(_login),
]);

List<LoginUser> _login(List<LoginUser> list, action) {
  list.clear();
  if (action.list == null) {
    return list;
  } else {
    list.addAll(action.list);
    return list;
  }
}


class GetLoginAction {
  final List<LoginUser> list;

  GetLoginAction(this.list);
}