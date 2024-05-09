import 'package:flutter/material.dart';

class BottomBarItem {
  final String title;
  final IconData icon;
  final Widget? widget;

  const BottomBarItem({
    required this.title,
    required this.icon,
    this.widget,
  });
}
