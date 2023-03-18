import 'package:collection/collection.dart';

class Country {
  int? id;
  String? countryName;
  String? countryCode;
  String? countryStart;
  int? isActive;
  dynamic createdAt;
  dynamic updatedAt;

  Country({
    this.id,
    this.countryName,
    this.countryCode,
    this.countryStart,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Country(id: $id, countryName: $countryName, countryCode: $countryCode, countryStart: $countryStart, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json['id'] as int?,
        countryName: json['country_name'] as String?,
        countryCode: json['country_code'] as String?,
        countryStart: json['country_start'] as String?,
        isActive: json['is_active'] as int?,
        createdAt: json['created_at'] as dynamic,
        updatedAt: json['updated_at'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'country_name': countryName,
        'country_code': countryCode,
        'country_start': countryStart,
        'is_active': isActive,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  Country copyWith({
    int? id,
    String? countryName,
    String? countryCode,
    String? countryStart,
    int? isActive,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    return Country(
      id: id ?? this.id,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
      countryStart: countryStart ?? this.countryStart,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Country) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      countryName.hashCode ^
      countryCode.hashCode ^
      countryStart.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
