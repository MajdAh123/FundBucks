import 'package:collection/collection.dart';

class SupportCardData {
  String? title;
  String? enTitle;
  String? content;
  String? enContent;

  SupportCardData({this.title, this.content, this.enTitle, this.enContent});

  @override
  String toString() =>
      'SupportCardData(title: $title, enTitle: $enTitle, enContent: $enContent, content: $content)';

  factory SupportCardData.fromJson(Map<String, dynamic> json) =>
      SupportCardData(
        title: json['title'] as String?,
        enTitle: json['en_title'] as String?,
        content: json['content'] as String?,
        enContent: json['en_content'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };

  SupportCardData copyWith({
    String? title,
    String? content,
  }) {
    return SupportCardData(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SupportCardData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode;
}
