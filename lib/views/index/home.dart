import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:wm_library_app/reducers/index-reducer.dart';
import 'package:wm_library_app/model/index.dart';

import 'package:wm_library_app/views/book_page/home.dart';


class IndexHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _IndexHomeState();
  }
}

class _IndexHomeState extends State<IndexHome> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreBuilder<WMState>(builder: (context, store) {
      return new Scaffold(
        body: store?.state?.index?.children[store?.state?.index?.currentIndex],
//          body: new BookPage(context),
        bottomNavigationBar: new BottomNavigationBar(
            onTap: (index) {
              print(index);
              store.dispatch(new IndexAction(new Index(index)));
            },
            currentIndex: store?.state?.index?.currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              new BottomNavigationBarItem(icon: new Icon(Icons.book), title: new Text('书籍')),
              new BottomNavigationBarItem(icon: new Icon(Icons.event_note), title: new Text('借阅')),
              new BottomNavigationBarItem(icon: new Icon(Icons.people), title: new Text('人员')),
              new BottomNavigationBarItem(icon: new Icon(Icons.settings), title: new Text('设置'))
            ]
        ),
      );
    });
  }
}