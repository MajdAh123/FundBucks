import 'package:app/app/utils/constant.dart';
import 'package:collection/collection.dart';
import 'package:timezone/standalone.dart' as tz;

import 'support_message.dart';

class Ticket {
  int? id;
  String? name;
  dynamic email;
  String? ticket;
  String? subject;
  int? userId;
  int? status;
  int? priority;
  dynamic lastReply;
  DateTime? createdAt;
  DateTime? updatedAt;
  SupportMessage? latestSupportMessage;

  Ticket({
    this.id,
    this.name,
    this.email,
    this.ticket,
    this.subject,
    this.userId,
    this.status,
    this.priority,
    this.lastReply,
    this.createdAt,
    this.updatedAt,
    this.latestSupportMessage,
  });

  @override
  String toString() {
    return 'Datum(id: $id, name: $name, email: $email, ticket: $ticket, subject: $subject, userId: $userId, status: $status, priority: $priority, lastReply: $lastReply, createdAt: $createdAt, updatedAt: $updatedAt, latestSupportMessage: $latestSupportMessage)';
  }

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as dynamic,
        ticket: json['ticket'] as String?,
        subject: json['subject'] as String?,
        userId: json['user_id'] as int?,
        status: json['status'] as int?,
        priority: json['priority'] as int?,
        lastReply: json['last_reply'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : tz.TZDateTime.parse(
                kuwaitTimezoneLocation, json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        latestSupportMessage: json['latest_support_message'] == null
            ? null
            : SupportMessage.fromJson(
                json['latest_support_message'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'ticket': ticket,
        'subject': subject,
        'user_id': userId,
        'status': status,
        'priority': priority,
        'last_reply': lastReply,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'latest_support_message': latestSupportMessage?.toJson(),
      };

  Ticket copyWith({
    int? id,
    String? name,
    dynamic email,
    String? ticket,
    String? subject,
    int? userId,
    int? status,
    int? priority,
    dynamic lastReply,
    DateTime? createdAt,
    DateTime? updatedAt,
    SupportMessage? latestSupportMessage,
  }) {
    return Ticket(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      ticket: ticket ?? this.ticket,
      subject: subject ?? this.subject,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      lastReply: lastReply ?? this.lastReply,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      latestSupportMessage: latestSupportMessage ?? this.latestSupportMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Ticket) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      ticket.hashCode ^
      subject.hashCode ^
      userId.hashCode ^
      status.hashCode ^
      priority.hashCode ^
      lastReply.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      latestSupportMessage.hashCode;
}
