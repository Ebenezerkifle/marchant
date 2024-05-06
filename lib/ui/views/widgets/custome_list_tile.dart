import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';

class CustomeListTile extends StatelessWidget {
  const CustomeListTile({
    super.key,
    this.imageUrl,
    this.width,
    required this.title,
    required this.onTap,
    this.price = 0.0,
    this.noImage = false,
    this.widget = const SizedBox(),
    this.discount = false,
    this.discountAmount = 0.0,
    this.dark = false,
    this.height,
    this.engagingWidget,
    this.description,
    this.maxLineForDescription,
    this.fit,
    this.center = false,
    this.selected = false,
    this.duration = 1,
    this.stackWidget,
    this.noPrice = true,
    this.bgdColor,
  });
  final String title;
  final List<String>? imageUrl;
  final VoidCallback onTap;
  final num price;
  final double? width;
  final Widget widget;
  final bool noImage;
  final bool discount;
  final double? discountAmount;
  final bool dark;
  final double? height;
  final Widget? engagingWidget;
  final String? description;
  final int? maxLineForDescription;
  final BoxFit? fit;
  final bool center;
  final bool selected;
  final int duration;
  final Widget? stackWidget;
  final bool noPrice;
  final Color? bgdColor;

  @override
  Widget build(BuildContext context) {
    double tileWidth = width ?? MediaQuery.of(context).size.width * .9;
    Color forgroundColor = dark ? kcWhite : kcPrimaryColorDark;
    Color backgroundColor = bgdColor ?? (dark ? kcPrimaryColorDark : kcWhite);
    double contentWidth = noImage ? tileWidth * .9 : tileWidth * .63;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        child: Stack(
          children: [
            Container(
              width: tileWidth,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: selected
                    ? Border.all(
                        width: 2,
                        color: kcPrimaryColor,
                        strokeAlign: BorderSide.strokeAlignInside,
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 3.0,
                    offset: const Offset(1, 2),
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: center
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        noImage
                            ? Container()
                            : Container(
                                padding: const EdgeInsets.only(right: 10.0),
                                height: height ?? tileWidth * .3,
                                width: height ?? tileWidth * .3,
                                child: imageUrl == null ||
                                        (imageUrl != null &&
                                            imageUrl!.length < 2)
                                    ? ImageBuilder(
                                        image: imageUrl?.first ?? '',
                                        height: height ?? tileWidth * .3,
                                        fit: fit ?? BoxFit.cover,
                                      )
                                    : Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: ImageBuilder(
                                              image: imageUrl?.first ?? '',
                                              height: height != null
                                                  ? height! * .8
                                                  : tileWidth * .25,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: ImageBuilder(
                                              image: imageUrl?[1] ?? '',
                                              height: height != null
                                                  ? height! * .8
                                                  : tileWidth * .2,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                        SizedBox(
                          width: contentWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppTextStyle.withColor(
                                  color: forgroundColor,
                                  style: AppTextStyle.h2Bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (description != null) ...[
                                Text(
                                  description ?? '',
                                  maxLines: maxLineForDescription ?? 2,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.withColor(
                                    color: forgroundColor,
                                    style: AppTextStyle.thinSmall,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 5),
                              noPrice
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '$price ETB',
                                              style: AppTextStyle.withColor(
                                                color: kcPrimaryColorDark,
                                                style: AppTextStyle.h4Bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        widget,
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    engagingWidget ?? Container(),
                  ],
                ),
              ),
            ),
            stackWidget ?? Container()
          ],
        ),
      ),
    );
  }
}
