import 'package:collection/collection.dart';

import 'support_card_data.dart';

class SupportCard {
  List<SupportCardData>? data;

  SupportCard({this.data});

  @override
  String toString() => 'SupportCard(data: $data)';

  factory SupportCard.fromJson(Map<String, dynamic> json) => SupportCard(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => SupportCardData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };

  SupportCard copyWith({
    List<SupportCardData>? data,
  }) {
    return SupportCard(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SupportCard) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => data.hashCode;
}
