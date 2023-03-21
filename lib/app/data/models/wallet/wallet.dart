import 'package:collection/collection.dart';

import 'data.dart';

class Wallet {
  Data? data;
  double? percent;
  double? value;
  double? newPercent;

  Wallet({this.data, this.percent, this.value, this.newPercent});

  @override
  String toString() {
    return 'Wallet(data: $data, percent: $percent, value: $value, newPercent: $newPercent)';
  }

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        percent: (json['percent'] as num?)?.toDouble(),
        value: (json['value'] as num?)?.toDouble(),
        newPercent: (json['newPercent'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'percent': percent,
        'value': value,
        'newPercent': newPercent,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Wallet) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      data.hashCode ^ percent.hashCode ^ value.hashCode ^ newPercent.hashCode;
}
