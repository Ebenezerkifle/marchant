import 'package:flutter/material.dart';

class CircularCardWidget extends StatelessWidget {
  const CircularCardWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.image = 'assets/images/category.jpg', // Provide a default image
  });

  final String title;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .10; // Reduce the size of the circle

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal padding
        child: Column(
          children: [
            ClipOval(
              child: Image.asset(
                image,
                width: width,
                height: width,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4.0), // Reduce the spacing
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0, // Reduce the text size
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
