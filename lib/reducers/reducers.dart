import 'package:wm_library_app/model/test.dart';
import 'package:wm_library_app/model/index.dart';
import 'package:wm_library_app/model/book.dart';
import 'package:wm_library_app/model/book_type.dart';
import 'test-reducer.dart';
import 'index-reducer.dart';
import 'book-reducer.dart';
import 'book-type-reducer.dart';

class WMState {
  Test test;
  Index index;
  List<Book> bookList = new List();
  List<BookType> bookTypeList = new List();

  ///构造方法
  WMState({this.test, this.index, this.bookList, this.bookTypeList});
}

WMState reducer(WMState state, action){
  return WMState(
    test: TestReducer(state.test, action),
    index: IndexReducer(state.index, action),
    bookList: BookReducer(state.bookList, action),
    bookTypeList: BookTypeReducer(state.bookTypeList, action),
  );
}