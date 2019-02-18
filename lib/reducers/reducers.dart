import 'package:wm_library_app/model/test.dart';
import 'test-reducer.dart';

class WMState {
  Test test;

  ///构造方法
  WMState({this.test});
}

WMState reducer(WMState state, action){
  return WMState(
    test: TestReducer(state.test, action),
  );
}