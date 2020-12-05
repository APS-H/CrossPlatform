import 'package:flutter/material.dart';

String dateString(DateTime currentDate) {
  return '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';
}

String timeString(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

class BoolComparable implements Comparable<BoolComparable> {
  const BoolComparable(this.data);

  final bool data;

  @override
  int compareTo(BoolComparable other) {
    return data
        ? (other.data ? 0 : 1)
        : (other.data ? -1 : 0);
  }
}
