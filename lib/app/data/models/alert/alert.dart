import 'package:collection/collection.dart';

class Alert {
  int? id;
  String? title;
  String? description;

  Alert({this.id, this.title, this.description});

  @override
  String toString() {
    return 'Alert(id: $id, title: $title, description: $description)';
  }

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };

  Alert copyWith({
    int? id,
    String? title,
    String? description,
  }) {
    return Alert(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Alert) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}
