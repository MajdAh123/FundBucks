import 'package:app/app/utils/constant.dart';
import 'package:collection/collection.dart';
import 'package:timezone/standalone.dart' as tz;

class InvestmentReport {
  int? id;
  num? balance;
  num? returnPercent;
  num? returnValue;
  num? totalValue;
  String? notes;
  DateTime? from;
  DateTime? to;

  InvestmentReport({
    this.id,
    this.balance,
    this.returnPercent,
    this.returnValue,
    this.totalValue,
    this.notes,
    this.from,
    this.to,
  });

  @override
  String toString() {
    return 'InvestmentReport(id: $id, balance: $balance, returnPercent: $returnPercent, returnValue: $returnValue, totalValue: $totalValue, notes: $notes, from: $from, to: $to)';
  }

  factory InvestmentReport.fromJson(Map<String, dynamic> json) =>
      InvestmentReport(
        id: json['id'] as int?,
        balance: json['balance'] as num?,
        returnPercent: json['return_percent'] as num?,
        returnValue: json['return_value'] as num?,
        totalValue: json['total_value'] as num?,
        notes: json['notes'] as String?,
        from: json['from'] == null
            ? null
            : tz.TZDateTime.parse(
                kuwaitTimezoneLocation, json['from'] as String),
        to: json['to'] == null
            ? null
            : tz.TZDateTime.parse(kuwaitTimezoneLocation, json['to'] as String),
      );

  Map<String, dynamic> toJson() => {
        'balance': balance,
        'return_percent': returnPercent,
        'return_value': returnValue,
        'total_value': totalValue,
        'notes': notes,
        'from': from?.toIso8601String(),
        'to': to?.toIso8601String(),
      };

  InvestmentReport copyWith({
    int? balance,
    int? returnPercent,
    int? returnValue,
    int? totalValue,
    dynamic notes,
    DateTime? from,
    DateTime? to,
  }) {
    return InvestmentReport(
      balance: balance ?? this.balance,
      returnPercent: returnPercent ?? this.returnPercent,
      returnValue: returnValue ?? this.returnValue,
      totalValue: totalValue ?? this.totalValue,
      notes: notes ?? this.notes,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! InvestmentReport) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      balance.hashCode ^
      returnPercent.hashCode ^
      returnValue.hashCode ^
      totalValue.hashCode ^
      notes.hashCode ^
      from.hashCode ^
      to.hashCode;
}
