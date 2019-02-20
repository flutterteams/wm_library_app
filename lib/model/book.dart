
class Book {
  Book(this.id, this.title, this.author, this.type_id, this.create_time, this.content);

  int id;
  String title;
  String author;
  int type_id;
  DateTime create_time;

  String content;

  // 命名构造函数
  Book.empty();

}