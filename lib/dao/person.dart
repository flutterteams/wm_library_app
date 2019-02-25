
import 'package:redux/redux.dart';
import 'package:wm_library_app/model/login_user.dart';
import 'package:wm_library_app/model/person.dart';
import 'package:wm_library_app/reducers/person-reducer.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';


class PersonDao {

  static get(Store<WMState> store, Map<String, dynamic> map) async {
    try {
      Response response;
      Dio dio = new Dio();

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      dio.options.headers = {HttpHeaders.AUTHORIZATION: 'Bearer ' + sharedPreferences.get('token')};
      print("===1===="+map.toString());


      response = await Dio().get("http://localhost:3000/api/admin/personnelList", queryParameters: map);
//      responseGet = await dio.get("/test?id=12&name=wendu");
//      responseGet = await dio.get("/test", queryParameters: {"id": '12', "name": "wendu"});
//      responsePost = await dio.post("http://localhost:3000/api/user/login", data: {"email": 'shimuhui@frogshealth.com', "password": "123456"});
//      response = await Future.wait([dio.get("http://localhost:3000/api/getCompany"), dio.post("http://localhost:3000/api/user/login", data: {"email": 'shimuhui@frogshealth.com', "password": "123456"})]); // 并发请求
//      print(response);
//      var data = json.decode(response);
      print(response);
      if (response.data['code'] == 1) {
        List<Person> list = new List();
        for (int i = 0; i < response.data['data'].length; i++) {
          list.add(Person(
              response.data['data'][i]['name'],
              response.data['data'][i]['email'],
              response.data['data'][i]['phone'],
              response.data['data'][i]['status'],
              response.data['data'][i]['id'])
          );
        }
        //print("===="+list.length.toString());
        store.dispatch(new GetPersonAction(list));
      }
    } catch (e) {
      return print(e);
    }
  }

  static addPerson(Store<WMState> store,String email) async {
    try {
      Response response;
      Dio dio = new Dio();
      Person person = store.state.person;
      print("====person===="+email);
      response = await dio.post(
          "http://localhost:3000/api/admin/addPersonnel",
          data: {
            "email": email,
          }
      );
      print(response.data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  static editPerson(Store<WMState> store,String user_id,String email,String status) async {
    try {
      Response response;
      Dio dio = new Dio();
      Person person = store.state.person;
      print("====person===="+person.status.toString());
      String user_id = person.id.toString();
      String email = person.email;
      String status = person.status.toString();
//      if(person.status == "在职"){
//        status = "0";
//      }else{
//        status = "1";
//      }

      print("=======user_id="+user_id+"=======email="+email+"====status="+status);
      response = await dio.post(
          "http://localhost:3000/api/admin/updatePersonnel",
          data: {
            "user_id": user_id,
            "email": email,
            "status": status,
          }
      );
      print(response.data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
