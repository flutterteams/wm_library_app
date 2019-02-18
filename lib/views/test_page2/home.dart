import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:wm_library_app/actions/test_page_action.dart';
import 'package:wm_library_app/model/test.dart';

class TestPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage2> {
  final Test test = new Test('123');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreBuilder<WMState>(builder: (context, store) {
      return new Scaffold(
          appBar: new AppBar(
              title: new Text('TestPage2')
          ),
          body: new RaisedButton(
              child: new Text('${store.state.test.login}'),
              onPressed: () => store.dispatch(new TestPageAction.change('test')))
      );
    });
  }
}