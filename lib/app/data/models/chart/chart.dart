
import 'package:app/app/data/models/models.dart';
import 'package:collection/collection.dart';

class Chart {
  InvestmentChart? investmentChart;
  List<Wallet>? wallet;

  Chart({this.investmentChart, this.wallet});

  @override
  String toString() => 'ChartDemo(chart: $investmentChart, wallet: $wallet)';

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        investmentChart: json['chart'] == null
            ? null
            : InvestmentChart.fromJson(json['chart'] as Map<String, dynamic>),
        wallet: json['wallet'] == null
            ? null
            : (json['wallet'] as List)
                .map((data) => Wallet.fromJson(data))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        'chart': investmentChart?.toJson(),
        // 'wallet': wallet?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Chart) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => investmentChart.hashCode;
}
