import 'package:collection/collection.dart';

import 'operation_data.dart';

class Deposit {
  List<OperationData>? data;

  Deposit({this.data});

  @override
  String toString() => 'Deposit(data: $data)';

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => OperationData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };

  Deposit copyWith({
    List<OperationData>? data,
  }) {
    return Deposit(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Deposit) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => data.hashCode;
}
