// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
      json['bookId'] as int,
      json['title'] as String,
      json['author'] as String,
      json['type_id'] as int,
      json['create_time'] == null
          ? null
          : DateTime.parse(json['create_time'] as String),
      json['content'] as String);
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'bookId': instance.id,
      'title': instance.title,
      'author': instance.author,
      'type_id': instance.type_id,
      'create_time': instance.create_time?.toIso8601String(),
      'content': instance.content
    };
