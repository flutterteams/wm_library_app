import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:wm_library_app/dao/book.dart';
import 'package:wm_library_app/dao/book_type.dart';
import 'package:intl/intl.dart';
import 'package:wm_library_app/reducers/add-book-reducer.dart';
import 'package:wm_library_app/model/book.dart';

class TypeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TypeListPageState();
  }
}

class _TypeListPageState extends State<TypeListPage> {
  Store<WMState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreBuilder<WMState>(builder: (context, store) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('选择分类'),
          ),
          body: RadioGroup()
      );
    });
  }

  Widget RadioGroup() {
    Map typeMap = _getStore().state.bookTypeMap;

//    var radio = typeList.map((i) {
//      return new RadioListTile(
//          value: i.id,
//          title: Text(i.name),
//          groupValue: _getStore().state.book.type_id,
//          onChanged: (value) => goBack(value)
//      );
//    });

    List<Widget> radio = new List();

    typeMap.forEach((k, v) {
      radio.add(new RadioListTile(
          value: k,
          title: Text(v),
          groupValue: _getStore().state.book.type_id,
          onChanged: (value) => goBack(value)
      ));
    });

    // 添加每个线
    final divided = ListTile.divideTiles(
      context: context,
      color: Colors.black,
      tiles: radio,
    ).toList();

    return new Column(
      children: divided,
    );
  }

  goBack(value) {
    _getStore().dispatch(new ChangeBookTypeAction(value));
    Navigator.pop(context);
  }
}