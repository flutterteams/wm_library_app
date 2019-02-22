import 'package:wm_library_app/views/book_page/home.dart';
import 'package:wm_library_app/views/borrow_page/home.dart';
import 'package:wm_library_app/views/person_page/home.dart';

class Index {
  Index(this.currentIndex);

  int currentIndex;

  List children = [
    new BookPage(),
    new BorrowPage(),
    new PersonPage(),
  ];

}