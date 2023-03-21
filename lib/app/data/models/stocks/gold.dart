import 'package:collection/collection.dart';

class Gold {
  double? close;
  double? change;
  double? changeP;

  Gold({this.close, this.change, this.changeP});

  @override
  String toString() {
    return 'Gold(close: $close, change: $change, changeP: $changeP)';
  }

  factory Gold.fromJson(Map<String, dynamic> json) => Gold(
        close: double.parse((json['close'])),
        change: double.parse((json['change'])),
        changeP: double.parse((json['change_p'])),
      );

  Map<String, dynamic> toJson() => {
        'close': close,
        'change': change,
        'change_p': changeP,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Gold) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => close.hashCode ^ change.hashCode ^ changeP.hashCode;
}
