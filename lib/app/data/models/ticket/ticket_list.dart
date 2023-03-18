import 'package:collection/collection.dart';

import 'ticket.dart';

class TicketList {
  List<Ticket>? data;

  TicketList({this.data});

  @override
  String toString() => 'Ticket(data: $data)';

  factory TicketList.fromJson(Map<String, dynamic> json) => TicketList(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Ticket.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };

  TicketList copyWith({
    List<Ticket>? data,
  }) {
    return TicketList(
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TicketList) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => data.hashCode;
}
