import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:wm_library_app/dao/book.dart';


import 'package:wm_library_app/reducers/add-book-reducer.dart';
import 'package:wm_library_app/reducers/book-reducer.dart';

import 'package:flutter/cupertino.dart';

class AddBookPage extends StatefulWidget {

  final String id;
  AddBookPage({this.id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddBookPageState();
  }
}

class _AddBookPageState extends State<AddBookPage> {
  Store<WMState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (widget.id != null) {
      BookDao.getId(_getStore(), widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map typeMap = _getStore().state.bookTypeMap;

    return new StoreBuilder<WMState>(builder: (context, store) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('新增书籍'),
          ),
          body: new Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: new Text(
                        '书名',
                        style: new TextStyle(
                            fontSize: 16.0
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new TextField(
                        controller: new TextEditingController.fromValue(TextEditingValue(
                          text: store.state.book.title == null ? '' : store.state.book.title,
                          selection: TextSelection.fromPosition(TextPosition(
                            affinity: TextAffinity.downstream,
                            offset: store.state.book.title == null ? 0 : store.state.book.title.length
                          ))
                        )),
                        decoration: new InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: '请输入书名',
                            hintStyle: new TextStyle(
                                color: Colors.black45
                            ),
                            border: InputBorder.none
                        ),
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        onChanged: (str) => store.dispatch(new ChangeBookNameAction(str)),
                      ),
                    )
                  ],
                ),
                new Divider(
                  color: Colors.black45,
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: new Text(
                          '作者',
                          style: new TextStyle(
                              fontSize: 16.0
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new TextField(
                          controller: new TextEditingController.fromValue(TextEditingValue(
                              text: store.state.book.author == null ? '' : store.state.book.author,
                              selection: TextSelection.fromPosition(TextPosition(
                                  affinity: TextAffinity.downstream,
                                  offset: store.state.book.author == null ? 0 : store.state.book.author.length
                              ))
                          )),
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(6.0),
                              hintText: '请输入作者',
                              hintStyle: new TextStyle(
                                color: Colors.black45
                              ),
                              border: InputBorder.none
                          ),
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          onChanged: (str) => store.dispatch(new ChangeBookEditorAction(str)),
                        ),
                      )
                    ],
                  ),
                ),
                new Divider(
                  color: Colors.black45,
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.fromLTRB(0.0, 4.0, 20.0, 0.0),
                        child: new Text(
                          '简介',
                          style: new TextStyle(
                              fontSize: 16.0
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new TextField(
                          controller: new TextEditingController.fromValue(TextEditingValue(
                              text: store.state.book.content == null ? '' : store.state.book.content,
                              selection: TextSelection.fromPosition(TextPosition(
                                  affinity: TextAffinity.downstream,
                                  offset: store.state.book.content == null ? 0 : store.state.book.content.length
                              ))
                          )),
                          maxLines: 18,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(6.0),
                              hintText: '请输入简介',
                              hintStyle: new TextStyle(
                                  color: Colors.black45
                              ),
                              border: InputBorder.none
                          ),
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          onChanged: (str) => store.dispatch(new ChangeBookContentAction(str)),
                        ),
                      )
                    ],
                  ),
                ),
                new Divider(
                  color: Colors.black45,
                ),
                new GestureDetector(
                  onTap: chooseType,
                  child: new Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 0.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Container(
//                              color: Colors.black12,
                              padding: const EdgeInsets.fromLTRB(0.0, 6.0, 26.0, 6.0),
                              child: new Text(
                                '分类',
                                style: new TextStyle(
                                    fontSize: 16.0
                                ),
                              ),
                            ),
                            new Text(
                              typeMap[store.state.book.type_id] == null ? '请选择分类' : typeMap[store.state.book.type_id],
                              style: new TextStyle(
                                fontSize: 16.0,
                                color: typeMap[store.state.book.type_id] == null ? Colors.black45 : Colors.black
                              )
                            ),
                          ],
                        ),
                        new Icon(Icons.arrow_right)
                      ],
                    ),
                  ),
                ),
                new Divider(
                  color: Colors.black45,
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: new RaisedButton(
                    child: new Text(
                      '保存',
                      style: new TextStyle(
                        fontSize: 16.0
                      ),
                    ),
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                    textTheme: ButtonTextTheme.normal,
                    color: Colors.blue,
                    disabledTextColor: Colors.white,
                    disabledColor: Colors.black12,
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    disabledElevation: 0.0,
                    onPressed: store.state.book.title == null || store.state.book.author == null || store.state.book.content == null ||
                      store.state.book.type_id == null ? null : save
                  ),
                )
              ],
            ),
          )
      );
    });
  }

  void chooseType() {
    Navigator.of(context).pushNamed('/type-list-page');
  }
  void save() async{
    var result;
    if (_getStore().state.book.id == null) {
      result = await BookDao.addBook(_getStore());
    } else {
      result = await BookDao.editBook(_getStore());
    }

    if (result['code'] == 1) {
      _getStore().dispatch(new GetBookAction({'page': 0}));
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: new Container(
              width: 100.0,
              height: 50.0,
              color: Colors.black45,
              child: new Center(
                child: new Text(
                  '保存失败',
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    decoration: TextDecoration.none
                  ),
                ),
              ),
            ),
          );
        }
      );
    }
  }
}