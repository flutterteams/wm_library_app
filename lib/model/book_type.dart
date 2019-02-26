import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'book_type.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class BookType {
  BookType(this.id, this.name);

  int id;
  String name;

  //不同的类使用不同的mixin即可
  factory BookType.fromJson(Map<String, dynamic> json) =>
      _$BookTypeFromJson(json);
  Map<String, dynamic> toJson() => _$BookTypeToJson(this);
}
