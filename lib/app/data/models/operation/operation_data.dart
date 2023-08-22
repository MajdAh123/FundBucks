import 'package:app/app/utils/constant.dart';
import 'package:collection/collection.dart';
import 'package:timezone/standalone.dart' as tz;

class OperationData {
  int? id;
  String? trx;
  dynamic currency;
  num? amount;
  num? amountDollar;
  bool? fromAdmin;
  DateTime? approveDate;
  DateTime? createdAt;

  OperationData({
    this.id,
    this.trx,
    this.currency,
    this.amount,
    this.amountDollar,
    this.fromAdmin,
    this.approveDate,
    this.createdAt,
  });

  @override
  String toString() {
    return 'Datum(id: $id, trx: $trx, currency: $currency, amount: $amount, amountDollar: $amountDollar, fromAdmin: $fromAdmin, approveDate: $approveDate createdAt: $createdAt)';
  }

  factory OperationData.fromJson(Map<String, dynamic> json) => OperationData(
        id: json['id'] as int?,
        trx: json['trx'] as String?,
        currency: json['currency'] as dynamic,
        amount: json['amount'] as num?,
        amountDollar: json['amount_dollar'] as num?,
        fromAdmin: json['from_admin'] as bool?,
        approveDate: json['approve_date'] == null
            ? null
            : tz.TZDateTime.parse(
                kuwaitTimezoneLocation, json['approve_date'] as String),
        createdAt: json['created_at'] == null
            ? null
            : tz.TZDateTime.parse(
                kuwaitTimezoneLocation, json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'trx': trx,
        'currency': currency,
        'amount': amount,
        'amount_dollar': amountDollar,
        'created_at': createdAt?.toIso8601String(),
      };

  OperationData copyWith({
    String? trx,
    dynamic currency,
    double? amount,
    double? amountDollar,
    DateTime? createdAt,
  }) {
    return OperationData(
      trx: trx ?? this.trx,
      currency: currency ?? this.currency,
      amount: amount ?? this.amount,
      amountDollar: amountDollar ?? this.amountDollar,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OperationData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      trx.hashCode ^
      currency.hashCode ^
      amount.hashCode ^
      amountDollar.hashCode ^
      createdAt.hashCode;
}
