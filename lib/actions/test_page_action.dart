
import 'package:wm_library_app/model/test.dart';

class TestPageAction {
  Test test;
  TestPageAction(this.test);

  TestPageAction.change(String s) {
    Test test2 = new Test(s);
    test = test2;
  }
}