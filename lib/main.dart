import 'package:flutter/material.dart';
import 'package:wm_library_app/views/test_page/home.dart';
import 'package:wm_library_app/routers/routers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
//import 'package:wm_library_app/store/store.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:wm_library_app/model/test.dart';

void main() {
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {

  final store = new Store<WMState>(
    reducer,
    initialState: new WMState(
      test: Test.empty()
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
          home: new TestPage(),
          routes: new Routers().routers,
        )
    );
  }
}
