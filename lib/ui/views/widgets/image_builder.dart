import 'dart:ui';

import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    super.key,
    required this.image,
    this.fit = BoxFit.cover,
    required this.height,
    this.width,
    this.circle = false,
    this.blured = false,
    this.errorBuilder,
  });

  final String image;
  final BoxFit fit;
  final double height;
  final double? width;
  final bool circle;
  final bool blured;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  bool _isUrl(String? string) {
    if (string == null) return false;
    final RegExp urlExp = RegExp(
      r'^((ftp|http|https)://|(www))[a-z0-9-]+(.[a-z0-9-]+)+(:[0-9]{1,5})?(/.*)?$',
    );
    return urlExp.hasMatch(string);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? MediaQuery.of(context).size.width, // Use bounded width
      child: ClipRRect(
        borderRadius: circle
            ? BorderRadius.circular(height / 2)
            : BorderRadius.circular(8),
        child: _isUrl(image)
            ? Image.network(
                image,
                fit: fit,
                errorBuilder: errorBuilder ??
                    (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.fitHeight,
                      );
                    },
              )
            : image.isNotEmpty
                ? Image.asset(
                    image,
                    fit: fit,
                  )
                : Center(
                    child: Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
      ),
    );
  }
}
