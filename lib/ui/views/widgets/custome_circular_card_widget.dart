import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';

class CircularCardWidget extends StatelessWidget {
  const CircularCardWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.image,
    this.icon,
  });

  final String title;
  final VoidCallback onTap;
  final String? image;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width * 0.12; // Adjust size as needed

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (icon != null)
                  ClipOval(
                    child: Container(
                      color: kcPrimaryColorDark, // Set background color
                      width: size,
                      height: size,
                      child: Icon(
                        icon!,
                        size: size * 0.9, // Adjust icon size as needed
                        color: Colors.white, // Set icon color
                      ),
                    ),
                  ),
                if (icon == null)
                  ClipOval(
                    child: ImageBuilder(
                      image: image ?? 'assets/images/category.jpg',
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/category.jpg',
                          width: size,
                          height: size,
                          fit: BoxFit.cover,
                        );
                      },
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
