import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wm_library_app/reducers/reducers.dart';
import 'package:wm_library_app/dao/book.dart';
import 'package:wm_library_app/dao/book_type.dart';
import 'package:intl/intl.dart';
import 'package:wm_library_app/views/book_page/add.dart';
import 'package:wm_library_app/model/book.dart';
import 'package:wm_library_app/reducers/add-book-reducer.dart';

class BookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BookPageState();
  }
}

class _BookPageState extends State<BookPage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        BookDao.getList(_getStore(), page: ++_getStore().state.bookMap['page']);
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_getStore().state.bookMap['page'] == 0) {
      BookDao.getList(_getStore());
      BookTypeDao.getTypeList(_getStore());
    }
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
            title: new Text('书籍管理'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add, size: 30, color: Colors.white),
                iconSize: 40,
                onPressed: add,
              ),
            ],
          ),
          body: listView());
    });
  }

  void add() {
    _getStore().dispatch(new ChangeBookAction(new Book.empty()));
    Navigator.of(context).pushNamed('/add-book-page');
  }

  void edit(Book book) {
    _getStore().dispatch(new ChangeBookAction(new Book.empty()));
//    Navigator.of(context).pushNamed('/add-book-page');
    Navigator.push<String>(context, new MaterialPageRoute(
      builder: (BuildContext context) {
        return new AddBookPage(id: book.id.toString());
      },
    ));
  }

  void del(int id) {
    BookDao.delBook(_getStore(), id);
  }

  Future<Null> _loadRefresh() async {
    await BookDao.getList(_getStore());
  }

  Widget listView() {
    List<Book> list = _getStore().state.bookMap.containsKey('list')
        ? _getStore().state.bookMap['list']
        : new List();
    Map typeMap = _getStore().state.bookTypeMap;

    final tiles = list.map((i) {
      return new GestureDetector(
        onHorizontalDragStart: (detail) => print('2344'),
        onHorizontalDragEnd: (detail) => print('2333'),
        onTap: () => edit(i),
        child: new Dismissible(
            key: new Key(i.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => del(i.id),
            background: new Container(
              color: Colors.black12,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.all(20.0),
                    child: new Text('下架'),
                  )
                ],
              ),
            ),
            child: new Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
              child: new Row(
                children: <Widget>[
                  new Image.asset('images/tx.jpeg',
                      height: 80.0, width: 66.0, fit: BoxFit.cover),
                  new Expanded(
                    child: new Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            i.title,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          new Container(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: new Text(i.author,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0)),
                          ),
                          new Container(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Expanded(
                                      child: new Text(typeMap[i.type_id] == null
                                          ? ''
                                          : typeMap[i.type_id])),
                                  new Text(
                                    new DateFormat('yyyy-MM-dd')
                                        .format(i.create_time),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      );
    });

    // 添加每个线
    final divided = ListTile.divideTiles(
      context: context,
      color: Colors.black,
      tiles: tiles,
    ).toList();

    return new RefreshIndicator(
        child: new ListView.builder(
          itemBuilder: (context, index) => divided[index],
          itemCount: list.length,
          controller: _scrollController,
        ),
        onRefresh: _loadRefresh);
  }
}
