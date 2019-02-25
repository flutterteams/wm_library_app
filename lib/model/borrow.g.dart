// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Borrow _$BorrowFromJson(Map<String, dynamic> json) {
  return Borrow(
      json['id'] as int,
      json['book_name'] as String,
      json['user_name'] as String,
      json['status'] as int,
      json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      json['create_time'] == null
          ? null
          : DateTime.parse(json['create_time'] as String),
      json['update_time'] == null
          ? null
          : DateTime.parse(json['update_time'] as String));
}

Map<String, dynamic> _$BorrowToJson(Borrow instance) => <String, dynamic>{
      'id': instance.id,
      'book_name': instance.book_name,
      'user_name': instance.user_name,
      'status': instance.status,
      'start_time': instance.start_time?.toIso8601String(),
      'create_time': instance.create_time?.toIso8601String(),
      'update_time': instance.update_time?.toIso8601String()
    };
