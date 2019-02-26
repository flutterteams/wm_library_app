import 'package:wm_library_app/views/login_page/login.dart';
import 'package:wm_library_app/views/person_page/add.dart';
import 'package:wm_library_app/views/person_page/edit.dart';
import 'package:wm_library_app/views/book_page/add.dart';
import 'package:wm_library_app/views/book_page/type_list.dart';

import 'package:wm_library_app/views/book_page/home.dart';
import 'package:wm_library_app/views/borrow_page/home.dart';
import 'package:wm_library_app/views/person_page/home.dart';

class Routers {
  var routers = {
    '/edit-person-page': (context) => new EditPersonPage(),
    '/add-person-page': (context) => new AddPersonPage(),
    '/login-page': (context) => new LoginPage(),
    '/add-book-page': (context) => new AddBookPage(),
    '/type-list-page': (context) => new TypeListPage(),
  };

  List children = [
    new BookPage(),
    new BorrowPage(),
    new PersonPage(),
  ];
}
