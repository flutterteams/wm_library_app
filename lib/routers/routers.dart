import 'package:wm_library_app/views/test_page/home.dart';
import 'package:wm_library_app/views/test_page2/home.dart';
import 'package:wm_library_app/views/book_page/add.dart';
import 'package:wm_library_app/views/book_page/type_list.dart';

class Routers {
  var routers = {
    '/add-book-page': (context) => new AddBookPage(),
    '/type-list-page': (context) => new TypeListPage(),
    '/test-page': (context) => new TestPage(),
    '/test-page2': (context) => new TestPage2()
  };
}