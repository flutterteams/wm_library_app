import 'package:flutter/material.dart';
import 'package:wm_library_app/model/person.dart';
import 'package:wm_library_app/routers/routers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';

import 'package:wm_library_app/model/index.dart';
import 'package:wm_library_app/model/book.dart';
import 'package:wm_library_app/views/login_page/login.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final store = new Store<WMState>(
    reducer,
    initialState: WMState.initState(),
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: new MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new LoginPage(),
          routes: new Routers().routers,
        ));
  }
}
