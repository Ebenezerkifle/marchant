import 'package:flutter/material.dart';

enum SettingOptions {
  shortCode,
  myDetail,
  credit,
  about,
  logout,
  changePass,
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
