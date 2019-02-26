import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'borrow.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Borrow {
  Borrow(this.id, this.book_name, this.user_name, this.status, this.start_time,
      this.create_time, this.update_time);

  int id;
  String book_name;
  String user_name;
  int status;
  DateTime start_time;
  DateTime create_time;
  DateTime update_time;

  // 命名构造函数
  Borrow.empty();

  //不同的类使用不同的mixin即可
  factory Borrow.fromJson(Map<String, dynamic> json) => _$BorrowFromJson(json);
  Map<String, dynamic> toJson() => _$BorrowToJson(this);
}
