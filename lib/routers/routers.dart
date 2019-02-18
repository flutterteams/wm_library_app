import 'package:wm_library_app/views/test_page/home.dart';
import 'package:wm_library_app/views/test_page2/home.dart';

class Routers {
  var routers = {
    '/test-page': (context) => new TestPage(),
    '/test-page2': (context) => new TestPage2()
  };
}