import 'package:flutter/material.dart';

class Log {
  final String time = TimeOfDay.now().toString().substring(10, 15);
  final String titre;
  final String description;

  Log(this.titre, this.description);
}