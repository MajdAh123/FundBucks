import 'package:collection/collection.dart';

class Pivot {
  int? planId;
  int? investmentTypeId;
  String? percent;
  String? color;

  Pivot({this.planId, this.investmentTypeId, this.percent, this.color});

  @override
  String toString() {
    return 'Pivot(planId: $planId, investmentTypeId: $investmentTypeId, percent: $percent, color: $color)';
  }

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        planId: json['plan_id'] as int?,
        investmentTypeId: json['investment_type_id'] as int?,
        percent: json['percent'] as String?,
        color: json['color'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'plan_id': planId,
        'investment_type_id': investmentTypeId,
        'percent': percent,
        'color': color,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Pivot) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      planId.hashCode ^
      investmentTypeId.hashCode ^
      percent.hashCode ^
      color.hashCode;
}
