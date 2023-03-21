import 'package:collection/collection.dart';

import 'gateway.dart';

class GatewayList {
  List<Gateway>? data;

  GatewayList({this.data});

  @override
  String toString() => 'GatewayList(data: $data)';

  factory GatewayList.fromJson(Map<String, dynamic> json) => GatewayList(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Gateway.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };

  GatewayList copyWith({
    List<Gateway>? data,
  }) {
    return GatewayList(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GatewayList) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => data.hashCode;
}
