import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:wm_library_app/dao/person.dart';
import 'package:wm_library_app/reducers/add-person-reducer.dart';
import 'package:wm_library_app/reducers/reducers.dart';


/**
 * AddPersonPage 页
 */
class AddPersonPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => new _AddPersonPage();

}

class _AddPersonPage extends State<AddPersonPage> {

  TextEditingController controller = TextEditingController();
  List <String> list ;

  Store<WMState> _getStore() {
    return StoreProvider.of(context);
  }

  _saveData(String email) async {

    var result = await PersonDao.addPerson(_getStore(), email);

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
    print({'content':controller.text.toString()});
    if(controller.text.length > 0){
      showDialog(
          context: context,
          builder: (context) => new AlertDialog(
              title: new Text("提示"),
              content: new Text("确定添加该用户？"),
              actions:<Widget>[
                new FlatButton(child:new Text("取消"), onPressed: (){
                  Navigator.of(context).pop();

                },),
                new FlatButton(child:new Text("确定"), onPressed: (){
                  _saveData(controller.text.toString()+"@frogshealth.com");
                  //_saveData(_getStore().state.person.email);
                  controller.clear();
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
      return new Scaffold(
           appBar: new AppBar(
             title: new Text("添加"),
             centerTitle: true,
             actions: <Widget>[
               new Container()
             ],
           ),
           body: new Center(
             child: new Column(
               children: <Widget>[

                 new Padding(
                   padding: new EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 45.0),
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
                               controller: controller,
                               keyboardType: TextInputType.emailAddress,
                               decoration: new InputDecoration(
                                 //contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                 contentPadding: EdgeInsets.all(8.0),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                 ),
                                 hintText: '请输入邮箱',
                               ),
                               //onChanged: (str) => store.dispatch(new ChangePersonEmailAction(str+"@frogshealth.com")),
                               onChanged: (str) {
                                 print("===onChanged===="+str);
                                 store.dispatch(new ChangePersonEmailAction(str));
                               } ,
                             ),
                           ),
                           new Text("@frogshealth.com",style: new TextStyle(fontSize: 16.0),
                           )
                         ],
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

}

