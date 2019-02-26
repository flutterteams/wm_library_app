import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library_app/dao/login.dart';
import 'package:wm_library_app/model/login_user.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:wm_library_app/views/index/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _pwdcontroller = new TextEditingController();

  List<LoginUser> list;
  SharedPreferences sharedPreferences;

  Store<WMState> _getStore() {
    return StoreProvider.of(context);
  }

  toLogin(String email, String password) async {
    print("=====" + email + "=====" + password);

    await LoginDao.get(_getStore(), email, password);

    List loginList = await _getStore().state.loginUser;

    print("====loginList===" + loginList.length.toString());

    if (loginList.isNotEmpty && loginList.length > 0) {
      //数据保存到本地
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("name", loginList[0].name);
      sharedPreferences.setString("token", loginList[0].token);

      print({'name': sharedPreferences.get("name")});
      print({'token': sharedPreferences.get("token")});

      Navigator.push(context, new MaterialPageRoute(builder: (context) {
        return new IndexHome();
      }));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "数据异常！",
                ),
              ));
    }
  }

  void toCheakData(String userName, String userPwd) {
    if (userName.isEmpty || userPwd.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "用户名或密码不能为空！",
                ),
              ));
    } else {
      toLogin(userName, userPwd);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new StoreBuilder<WMState>(builder: (context, store) {
      return new Scaffold(
//          body: new RaisedButton(
//              child: new Text('${store.state.test.login}'),
//              onPressed: () => Navigator.of(context).pushNamed('/test-page2'))

        body: new ListView(
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(
                      left: 30.0, top: 120.0, right: 30.0, bottom: 70.0),
                  child: new Image.asset(
                    'images/flutter_launcher.png',
                    scale: 1.2,
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                  child: new Stack(
                    alignment: new Alignment(1.0, 1.0),
                    //statck
                    children: <Widget>[
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Padding(
                              padding:
                                  new EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                              child: new Text(
                                '用户名',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            new Expanded(
                              child: new TextField(
                                controller: _userNameController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: new InputDecoration(
//                                  contentPadding: EdgeInsets.all(8.0),
//                                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      6.0, 10.0, 0.0, 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  hintText: '  请输入用户名',
                                ),
                              ),
                            ),
                          ]),
//                      new IconButton(
//                        icon: new Icon(Icons.clear, color: Colors.black45),
//                        onPressed: () {
//                          _phonecontroller.clear();
//                        },
//                      ),
                    ],
                  ),
                ),
                new Align(
                  alignment: Alignment.centerLeft,
                  //child: new Text('用户名错误',style: TextStyle(),),
                  child: new Container(
                    margin: const EdgeInsets.only(left: 90.0),
                    child: new Text(
                      '用户名错误',
                    ),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.fromLTRB(30.0, 5.0, 20.0, 0.0),
                  child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        new Padding(
                          padding: new EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                          child: new Text(
                            '密码',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        new Expanded(
                          child: new TextField(
                            controller: _pwdcontroller,
                            decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(
                                  6.0, 10.0, 0.0, 10.0),
                              //contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              hintText: '  请输入密码',
//                              suffixIcon: new IconButton(
//                                icon: new Icon(Icons.clear,
//                                    color: Colors.black45),
//                                onPressed: () {
//                                  _pwdcontroller.clear();
//                                },
//                              ),
                            ),
                            obscureText: true,
                          ),
                        ),
                      ]),
                ),
                new Align(
                  alignment: Alignment.centerLeft,
                  //child: new Text('用户名错误',style: TextStyle(),),
                  child: new Container(
                    margin: const EdgeInsets.fromLTRB(90.0, 5.0, 20.0, 45.0),
                    child: new Text(
                      '密码错误',
                    ),
                  ),
                ),
                new Container(
                  width: 150.0,
                  child: new Card(
                    color: Colors.blue,
                    elevation: 16.0,
                    child: new FlatButton(
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Text(
                          '登录',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                      onPressed: () {
                        toCheakData(
                            _userNameController.text, _pwdcontroller.text);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
