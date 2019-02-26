import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:wm_library_app/dao/borrow.dart';
import 'package:intl/intl.dart';
import 'package:wm_library_app/views/book_page/add.dart';
import 'package:wm_library_app/model/borrow.dart';
import 'package:wm_library_app/reducers/borrow-reducer.dart';

class BorrowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BorrowPageState();
  }
}

class _BorrowPageState extends State<BorrowPage> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    BorrowDao.getList(_getStore());
  }

  Store<WMState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new StoreBuilder<WMState>(builder: (context, store) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('借阅管理'),
          ),
          body: listView());
    });
  }

  Widget listView() {
    var list = _getStore().state.borrowList;

    Map statusMap = {
      0: '借阅中',
      1: '已预约',
      2: '取消预约',
      3: '已还书',
      4: '超时未还',
      5: '提醒还书'
    };

    Map colorMap = {
      0: Colors.green,
      1: Colors.green,
      2: Colors.grey,
      3: Colors.green,
      4: Colors.red,
      5: Colors.orange
    };

    final tiles = list.map((i) {
      return new Container(
        padding: EdgeInsets.all(20.0),
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                  child: new Text(
                    i.book_name,
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                new Text(
                  statusMap[i.status] == null ? '' : statusMap[i.status],
                  style: new TextStyle(
                    color:
                        colorMap[i.status] == null ? null : colorMap[i.status],
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Text(i.user_name),
                      new Text(' / '),
                      new Text(new DateFormat('yyyy年MM月').format(i.start_time))
                    ],
                  ),
                )
              ],
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
