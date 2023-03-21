import 'package:collection/collection.dart';

import 'alert.dart';

class AlertList {
  List<Alert>? data;

  AlertList({this.data});

  @override
  String toString() => 'AlertList(data: $data)';

  factory AlertList.fromJson(Map<String, dynamic> json) => AlertList(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Alert.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };

  AlertList copyWith({
    List<Alert>? data,
  }) {
    return AlertList(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AlertList) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => data.hashCode;
}
