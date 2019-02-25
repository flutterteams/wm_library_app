
import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'book.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()



class Book {
  Book(this.id, this.title, this.author, this.type_id, this.create_time, this.content);

  @JsonKey(name: 'bookId')
  int id;

  String title;
  String author;
  int type_id;
  DateTime create_time;

  String content;

  set name(String value) => title = value;



  // 命名构造函数
  Book.empty();

  @override
  String toString() {
    return 'Book{id: $id, title: $title, author: $author, type_id: $type_id, create_time: $create_time, content: $content}';
  }

  //不同的类使用不同的mixin即可
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);

}