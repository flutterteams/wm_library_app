
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:dio/dio.dart';
import 'package:wm_library_app/reducers/book-type-reducer.dart';
import 'package:wm_library_app/model/book_type.dart';

class BookTypeDao {

  static getTypeList(Store<WMState> store) async {
    try {
      Response response;
      Dio dio = new Dio();

      response = await Dio().get("http://localhost:3000/api/bookType");
      print(response.data);
      if (response.data['code'] == 1) {
        List<BookType> list = new List();
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(BookType(response.data['data'][i]['id'], response.data['data'][i]['name']));
        }
        store.dispatch(new GetBookTypeAction(list));
      }
    } catch (e) {
      return print(e);
    }
  }
}
