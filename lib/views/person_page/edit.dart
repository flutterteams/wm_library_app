import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wm_library_app/dao/person.dart';
import 'package:wm_library_app/reducers/add-person-reducer.dart';
import 'package:wm_library_app/reducers/reducers.dart';

import 'package:flutter/cupertino.dart';

class EditPersonPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPersonPageState();
  }
}

class _EditPersonPageState extends State<EditPersonPage> {


  TextEditingController controller = TextEditingController();
  TextEditingController typeController = TextEditingController();

  SharedPreferences sharedPreferences;
  int _newValue = 0;

  Store<WMState> _getStore() {
    return StoreProvider.of(context);
  }


  _saveData(String id,String email,String type) async {

    var result = await PersonDao.editPerson(_getStore(), id,email,type);

    print('保存结果：${result}');
    if (result['code'] == 1) {
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return new CupertinoAlertDialog(
              title: new Text('保存失败'),
            );
          }
      );
    }
  }

  //检测数据
  void _cheakData() {
    if(_getStore().state.person.id != null){
      showDialog(
          context: context,
          builder: (context) => new AlertDialog(
              title: new Text("提示"),
              content: new Text("确定修改？"),
              actions:<Widget>[
                new FlatButton(child:new Text("取消"), onPressed: (){
                  Navigator.of(context).pop();
                },),
                new FlatButton(child:new Text("确定"), onPressed: (){
                  _saveData(_getStore().state.person.id.toString(),_getStore().state.person.email.toString(),_getStore().state.person.status.toString());
                  Navigator.of(context).pop();

                },)
              ]
          )
      );
      //controller.clear();
    }else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("请输入邮箱地址！",),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<WMState>(builder: (context, store) {
      print("=====status====="+store.state.person.status.toString());
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('编辑员工'),
          ),
          body: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 15.0),
                  child: new Stack(
                    alignment: new Alignment(1.0, 1.0),
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Container(
                            //padding: const EdgeInsets.fromLTRB(5.0,0.0,5.0,35.0),
                            child: new Text(
                              '员工邮箱：',
                              style: new TextStyle(
                                  fontSize: 16.0
                              ),
                            ),
                          ),

                          new Expanded(
                            child: new TextField(
                              controller: new TextEditingController.fromValue(TextEditingValue(
                                  text: store.state.person.email == null ? '' : store.state.person.email,
                                  selection: TextSelection.fromPosition(TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: store.state.person.email == null ? 0 : store.state.person.email.length,
                                  )
                                  )
                              )),
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
//                                border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                ),
                                hintText: '  请输入邮箱',
                              ),
                              onChanged: (str) {
                                print("===onChanged===="+str);
                                store.dispatch(new ChangePersonEmailAction(str));
                              },
                            ),
                          ),
                          //new Text("@frogshealth.com",style: new TextStyle(fontSize: 16.0),)
                        ],
                      ),
                    ],
                  ),
                ),

                new Padding(
                  padding: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 45.0),
                  child: new Stack(
                    alignment: new Alignment(1.0, 1.0),
                    children: <Widget>[
                  new GestureDetector(
                    onTap: chooseType,
                    child: new Container(
                      //color: Colors.white,
                      padding: const EdgeInsets.only(top: 0.0),
                      child:  new Row(
                        children: <Widget>[
                          new Container(
                            //padding: const EdgeInsets.fromLTRB(5.0,0.0,5.0,35.0),
                            child: new Text(
                              '员工状态：',
                              style: new TextStyle(
                                  fontSize: 16.0
                              ),
                            ),
                          ),

                          new Expanded(
                            child: new TextField(
                              controller: new TextEditingController.fromValue(TextEditingValue(
                                  text: store.state.person.status == null ? 0 : store.state.person.status == 0 ? '在职':'离职',
                                  selection: TextSelection.fromPosition(TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: store.state.person.status == null ? 0 : store.state.person.status == 0
                                          ? store.state.person.status.toString().length : store.state.person.status.toString().length,
                                  )
                                  )
                              )),
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
//                                border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                ),
                                hintText: '  请输入',
                              ),
                              onChanged: (str) {
                                int status;
                                print("===onChanged===="+str);
                                if(str == "在职"){
                                   status = 0;
                                }else{
                                   status = 1;
                                }
                                print("===onChangedstatus===="+status.toString());
                                store.dispatch(new ChangePersonTypeAction(status));
                              },

                            ),
                          ),
                          //new Text("@frogshealth.com",style: new TextStyle(fontSize: 16.0),)
                        ],
                      ),
                    ),
                  ),

                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: _cheakData,
                  child: Text("保存"),
                ),
              ],
            ),
          )
      );
    });
  }

  void chooseType() {
    //Navigator.of(context).pushNamed('/type-list-page');
  }
}