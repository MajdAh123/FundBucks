import 'package:collection/collection.dart';

import 'investment_report.dart';

class InvestmentReportList {
  List<InvestmentReport>? data;

  InvestmentReportList({this.data});

  @override
  String toString() => 'InvestmentReportList(data: $data)';

  factory InvestmentReportList.fromJson(Map<String, dynamic> json) {
    return InvestmentReportList(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => InvestmentReport.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };

  InvestmentReportList copyWith({
    List<InvestmentReport>? data,
  }) {
    return InvestmentReportList(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! InvestmentReportList) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => data.hashCode;
}
