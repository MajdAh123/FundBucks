import 'package:collection/collection.dart';

import 'operation_data.dart';

class Withdraw {
  List<OperationData>? data;

  Withdraw({this.data});

  @override
  String toString() => 'Withdraw(data: $data)';

  factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => OperationData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };

  Withdraw copyWith({
    List<OperationData>? data,
  }) {
    return Withdraw(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Withdraw) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => data.hashCode;
}
