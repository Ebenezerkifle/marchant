import 'package:flutter/material.dart';

class SettingModel {
  final String title;
  final String? description;
  final IconData icon;

  SettingModel({
    required this.title,
    this.description,
    required this.icon,
  });
}
