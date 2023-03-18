import 'package:collection/collection.dart';

import 'pivot.dart';

class Data {
  int? id;
  String? name;
  String? enName;
  Pivot? pivot;

  Data({this.id, this.name, this.enName, this.pivot});

  @override
  String toString() =>
      'Data(id: $id, name: $name, name: $enName, pivot: $pivot)';

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        name: json['name'] as String?,
        enName: json['en_name'] as String?,
        pivot: json['pivot'] == null
            ? null
            : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'en_name': enName,
        'pivot': pivot?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ pivot.hashCode;
}
