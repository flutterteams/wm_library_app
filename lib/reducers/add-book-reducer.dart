import 'package:redux/redux.dart';
import 'package:wm_library_app/model/book.dart';

final AddBookReducer = combineReducers<Book>([
  TypedReducer<Book, ChangeBookAction>(_changeAll),
  TypedReducer<Book, ChangeBookTypeAction>(_changeType),
  TypedReducer<Book, ChangeBookNameAction>(_changeName),
  TypedReducer<Book, ChangeBookEditorAction>(_changeEditor),
  TypedReducer<Book, ChangeBookContentAction>(_changeContent),
]);

Book _changeAll(Book book, action) {
  book = action.book;
  return book;
}

Book _changeType(Book book, action) {
  book.type_id = action.id;
  return book;
}

Book _changeName(Book book, action) {
  book.title = action.name == '' ? null : action.name;
  return book;
}

Book _changeEditor(Book book, action) {
  book.author = action.editor == '' ? null : action.editor;
  return book;
}

Book _changeContent(Book book, action) {
  book.content = action.content == '' ? null : action.content;
  return book;
}

class ChangeBookAction {
  final Book book;
  ChangeBookAction(this.book);
}

class ChangeBookTypeAction {
  final int id;
  ChangeBookTypeAction(this.id);
}

class ChangeBookNameAction {
  final String name;
  ChangeBookNameAction(this.name);
}

class ChangeBookEditorAction {
  final String editor;
  ChangeBookEditorAction(this.editor);
}

class ChangeBookContentAction {
  final String content;
  ChangeBookContentAction(this.content);
}
