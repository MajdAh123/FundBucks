import 'package:collection/collection.dart';

class PlanInfo {
  String? name;
  String? enName;

  PlanInfo({this.name, this.enName});

  @override
  String toString() => 'PlanInfo(name: $name, enName: $enName)';

  factory PlanInfo.fromJson(Map<String, dynamic> json) => PlanInfo(
        name: json['name'] as String?,
        enName: json['en_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'en_name': enName,
      };

  PlanInfo copyWith({
    String? name,
    String? enName,
  }) {
    return PlanInfo(
      name: name ?? this.name,
      enName: enName ?? this.enName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PlanInfo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => name.hashCode ^ enName.hashCode;
}
