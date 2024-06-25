import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';

class CircularCardWidget extends StatelessWidget {
  const CircularCardWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.image = 'assets/images/category.jpg',
    this.icon,
  });

  final String title;
  final VoidCallback onTap;
  final String image;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.12; // Adjust size as needed

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Stack( // Use Stack for layering elements
              children: [
                ClipOval( // Background circle
                  child: Container(
                    color: kcPrimaryColorDark, // Set background color
                    width: size,
                    height: size,
                  ),
                ),
                if (icon != null) // Check if icon provided
                  Positioned.fill( // Position icon within circle
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        icon!,
                        size: size * 0.7, // Adjust icon size as needed
                        color: Colors.white, // Set icon color
                      ),
                    ),
                  ),
                if (icon == null) // Fallback for image (optional)
                  ClipOval(
                    child: ImageBuilder(
                      image: image,
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4.0),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
