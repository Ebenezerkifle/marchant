import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';

import 'bar_items.dart';

class BottomNav extends StatelessWidget {
  const BottomNav(
      {required this.items,
      required this.onTabSelected,
      required this.currentSelectedIndex,
      super.key});
  final List<BottomBarItem> items;
  final ValueChanged<int> onTabSelected;
  final int currentSelectedIndex;

  _updateIndex(int index) {
    onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemList = List.generate(items.length, (int index) {
      return _buildTabItem(
        item: items[index],
        index: index,
        onPressed: _updateIndex,
        context: context,
      );
    });
    return Container(
      // top border
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color.fromARGB(25, 0, 0, 0), width: 0.5),
        ),
      ),
      child: Row(
        //mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: itemList,
      ),
    );
  }

  Widget _buildTabItem({
    required BottomBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
    required BuildContext context,
  }) {
    bool current = currentSelectedIndex == index;
    Color color = current ? kcPrimaryColor : kcLightGrey;
    FontWeight fontWeight = current ? FontWeight.w600 : FontWeight.w400;
    return InkWell(
      onTap: () => onPressed(index),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            SizedBox(
              height: 60,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(item.icon, color: color, size: 17),
                  const SizedBox(height: 9),
                  Text(
                    item.title,
                    style: TextStyle(
                      color: color,
                      fontSize: 9.0,
                      fontWeight: fontWeight,
                    ),
                  )
                ],
              ),
            ),
            item.widget ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
