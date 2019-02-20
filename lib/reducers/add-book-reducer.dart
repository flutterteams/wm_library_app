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
  print(book.title);
  book = new Book(book.id, book.title, book.author, action.id, book.create_time, book.content);
  return book;
}

Book _changeName(Book book, action) {
  print(action.name);
  book = new Book(book.id, action.name == '' ? null : action.name, book.author, book.type_id, book.create_time, book.content);
  return book;
}

Book _changeEditor(Book book, action) {
  book = new Book(book.id, book.title, action.editor == '' ? null : action.editor, book.type_id, book.create_time, book.content);
  return book;
}

Book _changeContent(Book book, action) {
  book = new Book(book.id, book.title, book.author, book.type_id, book.create_time, action.content == '' ? null : action.content);
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