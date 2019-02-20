import 'package:flutter/material.dart';
import 'package:wm_library_app/routers/routers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';


import 'package:wm_library_app/model/test.dart';
import 'package:wm_library_app/model/index.dart';
import 'package:wm_library_app/model/book.dart';

import 'package:wm_library_app/views/test_page/home.dart';
import 'package:wm_library_app/views/index/home.dart';
import 'package:wm_library_app/views/book_page/home.dart';

void main() {
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {

  final store = new Store<WMState>(
    reducer,
    initialState: new WMState(
      test: Test.empty(),
      index: new Index(0),
      bookList: new List(),
      bookTypeList: new List(),
      book: Book.empty()
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: new MaterialApp (
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new IndexHome(),
          routes: new Routers().routers,
        )
    );
  }
}
