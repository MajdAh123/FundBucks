import 'package:app/app/data/models/models.dart';
import 'package:collection/collection.dart';

class SupportMessageList {
  List<SupportMessage>? data;

  SupportMessageList({this.data});

  @override
  String toString() => 'SupportMessageNew(data: $data)';

  factory SupportMessageList.fromJson(Map<String, dynamic> json) {
    return SupportMessageList(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SupportMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };

  SupportMessageList copyWith({
    List<SupportMessage>? data,
  }) {
    return SupportMessageList(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SupportMessageList) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => data.hashCode;
}
