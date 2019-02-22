import 'package:wm_library_app/views/login_page/login.dart';
import 'package:wm_library_app/views/person_page/add.dart';
import 'package:wm_library_app/views/person_page/edit.dart';
import 'package:wm_library_app/views/test_page/home.dart';
import 'package:wm_library_app/views/test_page2/home.dart';
import 'package:wm_library_app/views/book_page/add.dart';
import 'package:wm_library_app/views/book_page/type_list.dart';

class Routers {
  var routers = {
    '/edit-person-page': (context) => new EditPersonPage(),
    '/add-person-page': (context) => new AddPersonPage(),
    '/login-page': (context) => new LoginPage(),
    '/add-book-page': (context) => new AddBookPage(),
    '/type-list-page': (context) => new TypeListPage(),
    '/test-page': (context) => new TestPage(),
    '/test-page2': (context) => new TestPage2()
  };
}