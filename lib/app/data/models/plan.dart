import 'package:app/app/data/models/models.dart';
import 'package:get/get.dart';

class Plan {
  int? id;
  String? name;
  String? enName;
  String? notes;
  String? enNotes;
  String? interestPercent;
  PlanInfo? returnType;
  PlanInfo? withdrawalPeriod;

  Plan({
    this.id,
    this.name,
    this.enName,
    this.notes,
    this.enNotes,
    this.interestPercent,
    this.returnType,
    this.withdrawalPeriod,
  });

  @override
  String toString() {
    return 'Plan(id: $id, name: $name, enName: $enName, returnType: $returnType, withdrawalPeriod: $withdrawalPeriod, notes: $notes, enNotes: $enNotes)';
  }

  String getInterestType(int type) {
    switch (type) {
      case 1:
        return 'fixed'.tr;
      case 2:
        return 'growth'.tr;
    }
    return '';
  }

  String getWithdrawDays(int withdrawDays) {
    switch (withdrawDays) {
      case 0:
        return 'monthly'.tr;
      case 1:
        return 'quarterly'.tr;
      case 2:
        return 'semi_annual'.tr;
      case 3:
        return 'annual'.tr;
      case 4:
        return 'flexible'.tr;
    }
    return '';
  }

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json['id'] as int?,
        name: json['name'] as String?,
        enName: json['en_name'] as String?,
        returnType: json['return_type'] == null
            ? null
            : PlanInfo.fromJson(json['return_type']),
        withdrawalPeriod: json['withdrawal_period'] == null
            ? null
            : PlanInfo.fromJson(json['withdrawal_period']),
        notes: json['notes'] as String?,
        enNotes: json['en_notes'] as String?,
        interestPercent: json['interest_percent'] as String?,
      );

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'name': name,
  //       'en_name': enName,
  //       'interest_type': interestType,
  //       'withdraw_days': withdrawDays,
  //       'notes': notes,
  //       'en_notes': enNotes,
  //     };

  // @override
  // bool operator ==(Object other) {
  //   if (identical(other, this)) return true;
  //   if (other is! Plan) return false;
  //   final mapEquals = const DeepCollectionEquality().equals;
  //   return mapEquals(other.toJson(), toJson());
  // }

  // @override
  // int get hashCode =>
  //     id.hashCode ^
  //     name.hashCode ^
  //     enName.hashCode ^
  //     interestType.hashCode ^
  //     withdrawDays.hashCode ^
  //     notes.hashCode ^
  //     enNotes.hashCode;
}
