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
    return Container(
      decoration: BoxDecoration(
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius:
            circle ? null : const BorderRadius.all(Radius.circular(8)),
        image: !_isUrl(image) && image.isNotEmpty
            ? DecorationImage(
                image: AssetImage(image),
                fit: fit,
              )
            : null,
      ),
      height: height,
      width: width ?? height,
      child: _isUrl(image)
          ? Image.network(
              image,
              fit: fit,
              height: height,
              width: width ?? height,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/category.jpg',
                  fit: fit,
                  height: height,
                  width: width ?? height,
                );
              },
            )
          : image.isNotEmpty
              ? Image.asset(
                  image,
                  fit: fit,
                  height: height,
                  width: width ?? height,
                )
              : Image.asset(
                  'assets/images/category.jpg',
                  fit: fit,
                  height: height,
                  width: width ?? height,
                ),
    );
  }

  Widget bluredImage() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        child: ImageBuilder(
          image: 'assets/images/category.jpg',
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/category.jpg',
              fit: fit,
              height: height,
              width: width ?? height,
            );
          },
        ),
      ),
    );
  }
}
