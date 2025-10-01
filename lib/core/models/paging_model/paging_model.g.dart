// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PagingModelImpl<T> _$$PagingModelImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$PagingModelImpl<T>(
      total: (json['total'] as num?)?.toInt() ?? 0,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 0,
      perPage: (json['per_page'] as num?)?.toInt() ?? 0,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 0,
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
    );

Map<String, dynamic> _$$PagingModelImplToJson<T>(
  _$PagingModelImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'total': instance.total,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'data': instance.data.map(toJsonT).toList(),
    };
