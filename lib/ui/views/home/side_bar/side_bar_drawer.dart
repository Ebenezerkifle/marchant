import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/home/side_bar/side_bar_view.dart';

Drawer sideBarDrawer(BuildContext context) {
  return Drawer(
    width: screenWidth(context) * .7,
    backgroundColor: kcWhite,
    child: const SideBarView(),
  );
}
