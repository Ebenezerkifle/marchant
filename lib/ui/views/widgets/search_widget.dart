import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final double? width;
  final VoidCallback? onFilter;
  String? search;

  SearchWidget(
      {super.key,
      required this.searchController,
      this.width,
      this.onFilter,
      this.search});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.12,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: searchController,
                // style: AppTextStyle.h4Bold,
                style: const TextStyle(
                  color: Colors.white, // Set text color to white
                  fontSize: 16.0, // Adjust font size as needed
                  fontWeight: FontWeight.bold, // Adjust font weight as needed
                ),
                cursorColor: kcWhite,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.8),
                    size: 30,
                  ),
                  hintText: search,
                  hintStyle: AppTextStyle.withColor(
                    color: kcWhite,
                    style: AppTextStyle.h3Bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
