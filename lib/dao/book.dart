
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:dio/dio.dart';
import 'package:wm_library_app/reducers/book-reducer.dart';
import 'package:wm_library_app/model/book.dart';

class BookDao {
  static getList(Store<WMState> store, {page = 1, pageSize = 10}) async {
    try {
      Response response;
      Dio dio = new Dio();

      response = await Dio().get("http://localhost:3000/api/bookList", queryParameters: {"pageNo": page.toString(), "pageSize": pageSize.toString()});
//      responseGet = await dio.get("/test?id=12&name=wendu");
//      responseGet = await dio.get("/test", queryParameters: {"id": '12', "name": "wendu"});
//      responsePost = await dio.post("http://localhost:3000/api/user/login", data: {"email": 'shimuhui@frogshealth.com', "password": "123456"});
//      response = await Future.wait([dio.get("http://localhost:3000/api/getCompany"), dio.post("http://localhost:3000/api/user/login", data: {"email": 'shimuhui@frogshealth.com', "password": "123456"})]); // 并发请求
//      print(response);
//      var data = json.decode(response);
      print(response.data);
      if (response.data['code'] == 1) {
        List<Book> list = new List();
        for (int i = 0; i < response.data['data'].length; i++) {
          DateTime time = DateTime.parse(response.data['data'][i]['create_time']);
          list.add(Book(response.data['data'][i]['bookId'], response.data['data'][i]['title'], response.data['data'][i]['author'], response.data['data'][i]['type_id'], time));
        }
        store.dispatch(new GetBookAction(list));
      }
    } catch (e) {
      return print(e);
    }
  }
}
