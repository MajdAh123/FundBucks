import 'package:app/app/utils/constant.dart';
import 'package:collection/collection.dart';
import 'package:timezone/standalone.dart' as tz;

class Notification {
  int? id;
  String? title;
  String? description;
  int? userId;
  String? notifiableType;
  int? notifiableId;
  int? read;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic emailLogId;
  dynamic notificationTemplateId;

  Notification({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.notifiableType,
    this.notifiableId,
    this.read,
    this.createdAt,
    this.updatedAt,
    this.emailLogId,
    this.notificationTemplateId,
  });

  @override
  String toString() {
    return 'Notification(id: $id, title: $title, description: $description, userId: $userId, notifiableType: $notifiableType, notifiableId: $notifiableId, read: $read, createdAt: $createdAt, updatedAt: $updatedAt, emailLogId: $emailLogId, notificationTemplateId: $notificationTemplateId)';
  }

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        userId: json['user_id'] as int?,
        notifiableType: json['notifiable_type'] as String?,
        notifiableId: json['notifiable_id'] as int?,
        read: json['read'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : tz.TZDateTime.parse(
                kuwaitTimezoneLocation, json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : tz.TZDateTime.parse(
                kuwaitTimezoneLocation, json['updated_at'] as String),
        emailLogId: json['email_log_id'] as dynamic,
        notificationTemplateId: json['notification_template_id'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'user_id': userId,
        'notifiable_type': notifiableType,
        'notifiable_id': notifiableId,
        'read': read,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'email_log_id': emailLogId,
        'notification_template_id': notificationTemplateId,
      };

  Notification copyWith({
    int? id,
    String? title,
    String? description,
    int? userId,
    String? notifiableType,
    int? notifiableId,
    int? read,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic emailLogId,
    dynamic notificationTemplateId,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      notifiableType: notifiableType ?? this.notifiableType,
      notifiableId: notifiableId ?? this.notifiableId,
      read: read ?? this.read,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      emailLogId: emailLogId ?? this.emailLogId,
      notificationTemplateId:
          notificationTemplateId ?? this.notificationTemplateId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Notification) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      userId.hashCode ^
      notifiableType.hashCode ^
      notifiableId.hashCode ^
      read.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      emailLogId.hashCode ^
      notificationTemplateId.hashCode;
}
