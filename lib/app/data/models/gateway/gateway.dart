import 'package:collection/collection.dart';

class Gateway {
  int? id;
  int? code;
  String? name;
  String? enName;
  String? alias;

  Gateway({this.id, this.code, this.name, this.enName, this.alias});

  @override
  String toString() {
    return 'Gateway(id: $id, code: $code, name: $name, enName: $enName, alias: $alias)';
  }

  factory Gateway.fromJson(Map<String, dynamic> json) => Gateway(
        id: json['id'] as int?,
        code: json['code'] as int?,
        name: json['name'] as String?,
        enName: json['en_name'] as String?,
        alias: json['alias'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'en_name': enName,
        'alias': alias,
      };

  Gateway copyWith({
    int? id,
    int? code,
    String? name,
    String? enName,
    String? alias,
  }) {
    return Gateway(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      enName: enName ?? this.enName,
      alias: alias ?? this.alias,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Gateway) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      code.hashCode ^
      name.hashCode ^
      enName.hashCode ^
      alias.hashCode;
}
