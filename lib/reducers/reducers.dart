import 'package:wm_library_app/model/login_user.dart';
import 'package:wm_library_app/model/person.dart';
import 'package:wm_library_app/model/index.dart';
import 'package:wm_library_app/model/book.dart';
import 'package:wm_library_app/model/borrow.dart';
import 'index-reducer.dart';
import 'book-reducer.dart';
import 'book-type-reducer.dart';
import 'add-book-reducer.dart';
import 'borrow-reducer.dart';
import 'login-reducer.dart';
import 'person-reducer.dart';
import 'add-person-reducer.dart';

class WMState {
  Index index;
  Map bookMap;
  Map bookTypeMap;
  Book book;
  List<Borrow> borrowList;
  List<LoginUser> loginUser;
  List<Person> personList;
  Person person;

  ///构造方法
  WMState(
      {this.index,
      this.bookMap,
      this.bookTypeMap,
      this.book,
      this.borrowList,
      this.loginUser,
      this.personList,
      this.person});

  WMState.initState() {
    index = new Index(0);
    bookMap = {
      'page': 0,
    };
    bookTypeMap = new Map();
    book = Book.empty();
    borrowList = new List();
    loginUser = new List();
    personList = new List();
    person = Person.empty();
  }
}

WMState reducer(WMState state, action) {
  return WMState(
      index: IndexReducer(state.index, action),
      bookMap: BookReducer(state.bookMap, action),
      bookTypeMap: BookTypeReducer(state.bookTypeMap, action),
      book: AddBookReducer(state.book, action),
      borrowList: BorrowReducer(state.borrowList, action),
      loginUser: LoginReducer(state.loginUser, action),
      personList: PersonReducer(state.personList, action),
      person: AddPersonReducer(state.person, action));
}
