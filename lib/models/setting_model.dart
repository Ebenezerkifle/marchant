import 'package:flutter/material.dart';

enum SettingOptions {
  shortCode,
  language,
  myDetail,
  credit,
  about,
  logout,
}

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
