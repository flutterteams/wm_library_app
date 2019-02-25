
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:dio/dio.dart';
import 'package:wm_library_app/reducers/book-type-reducer.dart';
import 'package:wm_library_app/model/book_type.dart';
import 'package:wm_library_app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class BookTypeDao {

  static getTypeList(Store<WMState> store) async {
    try {
      Response response;
      Dio dio = new Dio();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      dio.options.headers = {HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')};

      response = await dio.get(Config.BASE_URL + "/api/bookType");
      print(response.data);
      if (response.data['code'] == 1) {
        List<BookType> list = new List();

        List<dynamic> bookTypeMap = response.data['data'];

        if (bookTypeMap.length > 0) {
          for (var item in bookTypeMap) {
            list.add(BookType.fromJson(item));
          }
        }

        store.dispatch(new GetBookTypeAction(list));
      }
    } catch (e) {
      return print(e);
    }
  }
}
