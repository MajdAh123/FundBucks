import 'package:collection/collection.dart';

import 'chart_data.dart';

class InvestmentChart {
  dynamic investments;

  InvestmentChart({this.investments});

  @override
  String toString() => 'Chart(investments: $investments)';

  factory InvestmentChart.fromJson(Map<String, dynamic> json) {
    var investmentChart = new InvestmentChart();
    if (json['investments']['days'] != null) {
      investmentChart.investments = json['investments'] == null
          ? null
          : DaysChartData.fromJson(json['investments'] as Map<String, dynamic>);
    } else if (json['investments']['months'] != null) {
      investmentChart.investments = json['investments'] == null
          ? null
          : MonthsChartData.fromJson(
              json['investments'] as Map<String, dynamic>);
    } else if (json['investments']['years'] != null) {
      investmentChart.investments = json['investments'] == null
          ? null
          : YearsChartData.fromJson(
              json['investments'] as Map<String, dynamic>);
    }
    return investmentChart;
  }

  Map<String, dynamic> toJson() => {
        'investments': investments?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! InvestmentChart) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => investments.hashCode;
}
