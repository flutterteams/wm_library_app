
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:dio/dio.dart';
import 'package:wm_library_app/reducers/book-reducer.dart';
import 'package:wm_library_app/model/book.dart';
import 'package:wm_library_app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:wm_library_app/reducers/add-book-reducer.dart';

class BookDao {
  static getList(Store<WMState> store, {page = 1, pageSize = 10}) async {
    try {
      Response response;
      Dio dio = new Dio();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      dio.options.headers = {HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')};

      response = await dio.get(Config.BASE_URL + "/api/bookList", queryParameters: {"pageNo": page.toString(), "pageSize": pageSize.toString(), "bookStatus" : '0'});
//      responseGet = await dio.get("/test?id=12&name=wendu");
//      responseGet = await dio.get("/test", queryParameters: {"id": '12', "name": "wendu"});
//      responsePost = await dio.post("http://localhost:3000/api/user/login", data: {"email": 'shimuhui@frogshealth.com', "password": "123456"});
//      response = await Future.wait([dio.get("http://localhost:3000/api/getCompany"), dio.post("http://localhost:3000/api/user/login", data: {"email": 'shimuhui@frogshealth.com', "password": "123456"})]); // 并发请求
//      print(response);
//      var data = json.decode(response);
//      print(response.data);
      if (response.data['code'] == 1) {
        List<Book> list = new List();

        List<dynamic> bookMap = response.data['data'];

        if (bookMap.length > 0) {
          for (var item in bookMap) {
            list.add(Book.fromJson(item));
          }
        }

        store.dispatch(new GetBookAction({'page': page}));
        if (page == 1){
          store.dispatch(new GetBookListAction(list));
        } else {
          store.dispatch(new GetBookAddListAction(list));
        }

      }
    } catch (e) {
      return print(e);
    }
  }

  static getId(Store<WMState> store, String id) async {
    try {
      Response response;
      Dio dio = new Dio();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      dio.options.headers = {HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')};

      response = await dio.get(Config.BASE_URL + "/api/bookDetails", queryParameters: {"bookId": id.toString()});

      if (response.data['code'] == 1) {

        List bookMap = response.data['data'];

        store.dispatch(new ChangeBookAction(Book.fromJson(bookMap[0])));

      }
    } catch (e) {
      return print(e);
    }
  }

  static addBook(Store<WMState> store) async {
    try {
      Response response;
      Dio dio = new Dio();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      dio.options.headers = {HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')};

      Book book = store.state.book;
      response = await dio.post(Config.BASE_URL + "/api/admin/addbook",
        data: {
          "type": book.type_id,
          "title": book.title,
          "author": book.author,
          "content": book.content,
          "url": '',
          "background": '',
        }
      );
      print(response.data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  static editBook(Store<WMState> store) async {
    try {
      Response response;
      Dio dio = new Dio();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      dio.options.headers = {HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')};

      Book book = store.state.book;
      response = await dio.post(
          Config.BASE_URL + "/api/admin/bookDetails",
          data: {
            "bookId": book.id,
            "typeId": book.type_id,
            "title": book.title,
            "author": book.author,
            "content": book.content,
            "url": '',
            "background": '',
          }
      );
      print(response.data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  static delBook(Store<WMState> store, int id) async {
    try {
      Response response;
      Dio dio = new Dio();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      dio.options.headers = {HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')};
      List bookList = store.state.bookMap.containsKey('list') ? store.state.bookMap['list'] : [];

      response = await dio.post(
          Config.BASE_URL + "/api/admin/offlineBook",
          data: {
            "bookId": id,
          }
      );
      print(response.data);
      if (response.data['code'] == 1) {

        for (int i = 0; i < bookList.length; i++) {
          if (bookList[i].id == id) {
            bookList.removeAt(i);
          }
        }
        store.dispatch(new GetBookListAction(bookList));
      }
    } catch (e) {
      return print(e);
    }
  }
}
