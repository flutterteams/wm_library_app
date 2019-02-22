
import 'package:redux/redux.dart';
import 'package:wm_library_app/model/login_user.dart';
import 'package:wm_library_app/reducers/login-reducer.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:dio/dio.dart';


class LoginDao {

  //static get(Store<WMState> store, Map<String, dynamic> map) async {
  static get(Store<WMState> store, String name,String pwd) async {
    try {
      Response response;
      Dio dio = new Dio();

      print("===1===="+name.toString()+"====="+pwd.toString());

      //{"name":name,"password":pwd}
      response = await Dio().post("http://localhost:3000/api/admin/login", data: {"name":name,"password":pwd});
      print(response);
      if (response.data['code'] == 1) {
        List<LoginUser> list = new List();
        list.add( LoginUser(response.data['data']['token'], response.data['data']['name'],));
//        for (int i = 0; i < response.data['data'].length; i++) {
//          list.add( LoginUser(response.data['data']['token'], response.data['data']['name'],));
//        }
        store.dispatch(new GetLoginAction(list));
        return response.data['data'];
      }
    } catch (e) {
      return print(e);
    }
  }
}
