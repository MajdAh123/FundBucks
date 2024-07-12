import 'package:collection/collection.dart';

class CountryNational {
  int? id;
  String? countryName;
  String? countryCode;

  CountryNational({
    this.id,
    this.countryName,
    this.countryCode,
  });

  @override
  String toString() {
    return 'Country(id: $id, countryName: $countryName, countryCode: $countryCode, )';
  }

  factory CountryNational.fromJson(Map<String, dynamic> json) =>
      CountryNational(
        id: json['id'] as int?,
        countryName: json['country_name'] as String?,
        countryCode: json['country_code'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'country_name': countryName,
        'country_code': countryCode,
      };

  CountryNational copyWith({
    int? id,
    String? countryName,
    String? countryCode,
    String? countryStart,
    int? isActive,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    return CountryNational(
      id: id ?? this.id,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CountryNational) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ countryName.hashCode ^ countryCode.hashCode;
}
