import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library_app/dao/person.dart';
import 'package:wm_library_app/model/person.dart';
import 'package:wm_library_app/reducers/add-person-reducer.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:intl/intl.dart';

class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonPageState();
  }
}

class _PersonPageState extends State<PersonPage> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    PersonDao.get(_getStore(),{"pageSize":"10","pageNo":"1"});

  }

  Store<WMState> _getStore() {
    return StoreProvider.of(context);
  }


  void add() {
    _getStore().dispatch(new ChangePersonAction(new Person.empty()));
    Navigator.of(context).pushNamed('/add-person-page');
  }

  void edit(Person person) {
    _getStore().dispatch(new ChangePersonAction(person));
    Navigator.of(context).pushNamed('/edit-person-page');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreBuilder<WMState>(builder: (context, store) {
      return new RefreshIndicator(
          color: Colors.amberAccent,
          child: new Scaffold(
              appBar: new AppBar(
                title: new Text('人员管理'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add, size: 30, color: Colors.white),
                    iconSize: 40,
                    onPressed: add,
                  ),
                ],
              ),
              body: listView(),
          ),
          onRefresh: _loadRefresh
      );
    });
  }

  Future<Null> _loadRefresh() async{

  }

  Widget listView() {

    List list = _getStore().state.personList;

    return new ListView.separated(
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) => new Divider(),
      itemBuilder: (context,item){
        return buildListData(context,list[item]);
      },

    );
  }

  Widget buildListData(BuildContext context, Person item){
    return new ListTile(
      isThreeLine: false,

      leading: new Image.asset('images/flutter_launcher.png', scale: 1.2,),
      title: new Text(item.name == null ? "测试" : item.name),
      subtitle: new Text(item.email == null ? "测试" : item.email),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onLongPress: (){},
      //修改功能
      onTap: () => edit(item),
    );
  }

}
