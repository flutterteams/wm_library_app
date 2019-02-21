
class Borrow {
  Borrow(this.id, this.book_name, this.user_name, this.status, this.start_time, this.create_time, this.update_time);

  int id;
  String book_name;
  String user_name;
  int status;
  DateTime start_time;
  DateTime create_time;
  DateTime update_time;

  // 命名构造函数
  Borrow.empty();

}