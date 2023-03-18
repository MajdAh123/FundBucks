import 'package:collection/collection.dart';

import 'dao.dart';
import 'gold.dart';
import 'oil.dart';

class Stocks {
  Oil? oil;
  Gold? gold;
  Dao? dao;

  Stocks({this.oil, this.gold, this.dao});

  @override
  String toString() => 'Stocks(oil: $oil, gold: $gold, dao: $dao)';

  factory Stocks.fromJson(Map<String, dynamic> json) => Stocks(
        oil: json['oil'] == null
            ? null
            : Oil.fromJson(json['oil'] as Map<String, dynamic>),
        gold: json['gold'] == null
            ? null
            : Gold.fromJson(json['gold'] as Map<String, dynamic>),
        dao: json['dao'] == null
            ? null
            : Dao.fromJson(json['dao'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'oil': oil?.toJson(),
        'gold': gold?.toJson(),
        'dao': dao?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Stocks) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => oil.hashCode ^ gold.hashCode ^ dao.hashCode;
}
