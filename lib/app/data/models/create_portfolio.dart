
import 'currency.dart';
import 'plan.dart';

class CreatePortfolio {
  List<Plan>? plans;
  List<Currency>? currencies;

  CreatePortfolio({this.plans, this.currencies});

  @override
  String toString() => 'Data(plans: $plans, currencies: $currencies)';

  factory CreatePortfolio.fromJson(Map<String, dynamic> json) =>
      CreatePortfolio(
        plans: (json['plans'] as List<dynamic>?)
            ?.map((e) => Plan.fromJson(e as Map<String, dynamic>))
            .toList(),
        currencies: (json['currencies'] as List<dynamic>?)
            ?.map((e) => Currency.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  // Map<String, dynamic> toJson() => {
  //       'plans': plans?.map((e) => e.toJson()).toList(),
  //       'currencies': currencies?.map((e) => e.toJson()).toList(),
  //     };

  // @override
  // bool operator ==(Object other) {
  //   if (identical(other, this)) return true;
  //   if (other is! CreatePortfolio) return false;
  //   final mapEquals = const DeepCollectionEquality().equals;
  //   return mapEquals(other.toJson(), toJson());
  // }

  @override
  int get hashCode => plans.hashCode ^ currencies.hashCode;
}
