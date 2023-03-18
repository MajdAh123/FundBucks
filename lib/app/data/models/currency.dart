import 'package:collection/collection.dart';

class Currency {
  int? id;
  String? currencyId;
  String? currencySign;

  Currency({this.id, this.currencyId, this.currencySign});

  @override
  String toString() {
    return 'Currency(id: $id, currencyId: $currencyId, currencySign: $currencySign)';
  }

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json['id'] as int?,
        currencyId: json['currency_id'] as String?,
        currencySign: json['currency_sign'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'currency_id': currencyId,
        'currency_sign': currencySign,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Currency) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ currencyId.hashCode ^ currencySign.hashCode;
}
