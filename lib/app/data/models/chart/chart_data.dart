import 'package:app/app/data/models/models.dart';
import 'package:collection/collection.dart';

class DaysChartData {
  List<String>? days;
  List<num>? totalInvestmentAmount;
  FirstDeposit? firstDeposit;

  DaysChartData({this.days, this.totalInvestmentAmount, this.firstDeposit});

  @override
  String toString() {
    return 'DaysChartData(days: $days, totalInvestmentAmount: $totalInvestmentAmount, firstDeposit: $firstDeposit)';
  }

  factory DaysChartData.fromJson(Map<String, dynamic> json) => DaysChartData(
        days: List<String>.from(json['days']),
        totalInvestmentAmount: List<num>.from(json['total_investment_amount']),
        firstDeposit: json['deposit'] == null
            ? null
            : FirstDeposit.fromJson(json['deposit']),
      );

  Map<String, dynamic> toJson() => {
        'days': days,
        'total_investment_amount': totalInvestmentAmount,
        'deposit': firstDeposit?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DaysChartData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => days.hashCode ^ totalInvestmentAmount.hashCode;
}

class MonthsChartData {
  List<String>? months;
  List<num>? totalInvestmentAmount;
  FirstDeposit? firstDeposit;

  MonthsChartData({this.months, this.totalInvestmentAmount, this.firstDeposit});

  @override
  String toString() {
    return 'MonthsChartData(months: $months, totalInvestmentAmount: $totalInvestmentAmount, firstDeposit: $firstDeposit)';
  }

  factory MonthsChartData.fromJson(Map<String, dynamic> json) =>
      MonthsChartData(
        months: List<String>.from(json['months']),
        totalInvestmentAmount: List<num>.from(json['total_investment_amount']),
        firstDeposit: json['deposit'] == null
            ? null
            : FirstDeposit.fromJson(json['deposit']),
      );

  Map<String, dynamic> toJson() => {
        'months': months,
        'total_investment_amount': totalInvestmentAmount,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MonthsChartData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => months.hashCode ^ totalInvestmentAmount.hashCode;
}

class YearsChartData {
  List<String>? years;
  List<num>? totalInvestmentAmount;
  FirstDeposit? firstDeposit;

  YearsChartData({this.years, this.totalInvestmentAmount, this.firstDeposit});

  @override
  String toString() {
    return 'Deposits(years: $years, totalInvestmentAmount: $totalInvestmentAmount, firstDeposit: $firstDeposit)';
  }

  factory YearsChartData.fromJson(Map<String, dynamic> json) => YearsChartData(
        years: List<String>.from(json['years']),
        totalInvestmentAmount: List<num>.from(json['total_investment_amount']),
        firstDeposit: json['deposit'] == null
            ? null
            : FirstDeposit.fromJson(json['deposit']),
      );

  Map<String, dynamic> toJson() => {
        'years': years,
        'total_investment_amount': totalInvestmentAmount,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! YearsChartData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => years.hashCode ^ totalInvestmentAmount.hashCode;
}
