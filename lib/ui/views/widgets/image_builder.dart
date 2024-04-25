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
  });
  final String image;
  final BoxFit fit;
  final double height;
  final double? width;
  final bool circle;
  final bool blured;

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
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        image: image != "" && _isUrl(image)
            ? DecorationImage(image: NetworkImage(image), fit: fit)
            : DecorationImage(
                image: AssetImage(
                  image != '' ? image : 'assets/images/order_delivery.png',
                ),
                fit: fit,
              ),
      ),
      height: height,
      width: width ?? height,
    );
  }

  bluredImage() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        child: ImageBuilder(
          image: 'assets/images/student.jpg',
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
