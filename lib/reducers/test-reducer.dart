import 'package:redux/redux.dart';
import 'package:wm_library_app/model/test.dart';
import 'package:wm_library_app/actions/test_page_action.dart';

final TestReducer = combineReducers<Test>([
  TypedReducer<Test, TestPageAction>(_updateLoaded),
]);

Test _updateLoaded(Test test, action) {
  test = action.test;
  return test;
}