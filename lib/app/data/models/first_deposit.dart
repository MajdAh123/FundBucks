import 'package:app/app/utils/constant.dart';
import 'package:collection/collection.dart';
import 'package:timezone/standalone.dart' as tz;

class FirstDeposit {
  DateTime? date;
  num? value;

  FirstDeposit({this.date, this.value});

  @override
  String toString() => 'FirstDeposit(date: $date, value: $value)';

  factory FirstDeposit.fromJson(Map<String, dynamic> json) => FirstDeposit(
        date: json['date'] == null
            ? null
            : tz.TZDateTime.parse(
                kuwaitTimezoneLocation, json['date'] as String),
        value: json['value'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'date': date?.toIso8601String(),
        'value': value,
      };

  FirstDeposit copyWith({
    tz.TZDateTime? date,
    double? value,
  }) {
    return FirstDeposit(
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! FirstDeposit) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => date.hashCode ^ value.hashCode;
}
