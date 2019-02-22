
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:dio/dio.dart';
import 'package:wm_library_app/reducers/borrow-reducer.dart';
import 'package:wm_library_app/model/borrow.dart';
import 'package:wm_library_app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class BorrowDao {
  static getList(Store<WMState> store, {page = 1, pageSize = 10}) async {
    try {
      Response response;
      Dio dio = new Dio();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      dio.options.headers = {HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')};

      response = await dio.get(Config.BASE_URL + "/api/admin/getBorrowBookList", queryParameters: {"page_no": page.toString(), "page_size": pageSize.toString()});

      print(response.data);
      if (response.data['code'] == 1) {
        List<Borrow> list = new List();

        List data = response.data['data']['rows'];

        for (int i = 0; i < data.length; i++) {
          DateTime create_time = DateTime.parse(data[i]['create_time']);
          DateTime start_time = DateTime.parse(data[i]['start_time']);
          DateTime update_time = DateTime.parse(data[i]['update_time']);

          list.add(
              Borrow(
                  data[i]['id'],
                  data[i]['book_name'],
                  data[i]['user_name'],
                  data[i]['status'],
                  start_time,
                  create_time,
                  update_time
              ));
        }
        store.dispatch(new GetBorrowAction(list));
      }
    } catch (e) {
      return print(e);
    }
  }
}
