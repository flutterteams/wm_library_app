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
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      dio.options.headers = {
        HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')
      };

      response = await dio.get(Config.BASE_URL + "/api/admin/getBorrowBookList",
          queryParameters: {
            "page_no": page.toString(),
            "page_size": pageSize.toString()
          });

      print(response.data);
      if (response.data['code'] == 1) {
        List<Borrow> list = new List();

        List<dynamic> borrowMap = response.data['data']['rows'];

        if (borrowMap.length > 0) {
          for (var item in borrowMap) {
            list.add(Borrow.fromJson(item));
          }
        }

        store.dispatch(new GetBorrowAction(list));
      }
    } catch (e) {
      return print(e);
    }
  }
}
