import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new StoreBuilder<WMState>(builder: (context, store) {
      return new Scaffold(
          appBar: new AppBar(
              title: new Text('My_TestPage')
          ),
          body: new RaisedButton(
              child: new Text('${store.state.test.login}'),
              onPressed: () => Navigator.of(context).pushNamed('/test-page2'))
      );
    });
  }
}