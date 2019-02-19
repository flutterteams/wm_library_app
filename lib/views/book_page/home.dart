import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:wm_library_app/dao/book.dart';
import 'package:wm_library_app/dao/book_type.dart';
import 'package:intl/intl.dart';

class BookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BookPageState();
  }
}

class _BookPageState extends State<BookPage> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    BookDao.getList(_getStore());
    BookTypeDao.getTypeList(_getStore());
  }

  Store<WMState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new StoreBuilder<WMState>(builder: (context, store) {
      return new RefreshIndicator(
        color: Colors.amberAccent,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text('书籍管理'),
          ),
          body: listView()
        ),
        onRefresh: _loadRefresh
      );
    });
  }

  Future<Null> _loadRefresh() async{
    print('12345678');
    await Future.delayed(Duration(seconds: 3), () {
      print('refresh');
//      setState(() {
//        list = List.generate(20, (i) => '哈喽,我是新刷新的 $i');
//      });
    });
  }

  Widget listView() {

    var list = _getStore().state.bookList;
    List typeList = _getStore().state.bookTypeList;

    Map typeMap = new Map();

    for(int i = 0; i < typeList.length; i++){
      typeMap[typeList[i].id] = typeList[i].name;
    }

    final tiles = list.map((i) {
      return new Container(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: new Row(
          children: <Widget>[
            new Image.asset('images/tx.jpeg', height: 80.0, width: 66.0, fit: BoxFit.cover),
            new Expanded(
              child: new Container(
                padding: const EdgeInsets.only(left: 20.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      i.title,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: new Text(
                          i.author,
                          style: new TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0
                          )
                      ),
                    ),
                    new Container(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Expanded(child: new Text(typeMap[i.type_id] == null ? '' : typeMap[i.type_id])),
                            new Text(
                              new DateFormat('yyyy-MM-dd').format(i.create_time),
                            ),
                          ],
                        )
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });


    // 添加每个线
    final divided = ListTile.divideTiles(
      context: context,
      color: Colors.black,
      tiles: tiles,
    ).toList();

    return new ListView(
      children: divided,
    );
  }
}
