import 'package:app/app/utils/constant.dart';
import 'package:collection/collection.dart';
import 'package:timezone/standalone.dart' as tz;

class SupportMessage {
  int? id;
  int? ticketId;
  int? userId;
  String? message;
  int? isAdmin;
  String? attachment;
  String? adminAvatar;
  DateTime? createdAt;
  DateTime? updatedAt;

  SupportMessage({
    this.id,
    this.ticketId,
    this.userId,
    this.message,
    this.isAdmin,
    this.attachment,
    this.adminAvatar,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'LatestSupportMessage(id: $id, ticketId: $ticketId, userId: $userId, message: $message, isAdmin: $isAdmin, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory SupportMessage.fromJson(Map<String, dynamic> json) {
    return SupportMessage(
      id: json['id'] == null ? null : json['id'] as int?,
      ticketId: json['ticket_id'] == null ? null : json['ticket_id'] as int?,
      userId: json['user_id'] == null ? null : json['user_id'] as int?,
      message: json['message'] == null ? null : json['message'] as String?,
      isAdmin: json['is_admin'] == null ? null : json['is_admin'] as int?,
      attachment:
          json['attachment'] == null ? null : json['attachment'] as String?,
      adminAvatar:
          json['admin_avatar'] == null ? null : json['admin_avatar'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : tz.TZDateTime.parse(
              kuwaitTimezoneLocation, json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'ticket_id': ticketId,
        'user_id': userId,
        'message': message,
        'is_admin': isAdmin,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  SupportMessage copyWith({
    int? id,
    int? ticketId,
    int? userId,
    String? message,
    int? isAdmin,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SupportMessage(
      id: id ?? this.id,
      ticketId: ticketId ?? this.ticketId,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      isAdmin: isAdmin ?? this.isAdmin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SupportMessage) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      ticketId.hashCode ^
      userId.hashCode ^
      message.hashCode ^
      isAdmin.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
