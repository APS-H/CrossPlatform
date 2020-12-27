import 'package:flutter/material.dart';

class Shift {
  const Shift(this.name, this.startTime, this.endTime);

  final String name;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
}
