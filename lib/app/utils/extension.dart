import 'package:flutter/material.dart';

extension MapIndexed on Iterable {
  Iterable<U> mapIndexed<T, U>(U Function(T e, int i) f) {
    int i = 0;
    return map<U>((it) {
      final t = i;
      i++;
      return f(it, t);
    });
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDay(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
