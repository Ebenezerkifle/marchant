import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'manu_product_detail_viewmodel.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';


class ManuProductDetailView extends StackedView<ManuProductDetailViewModel> {
  const ManuProductDetailView({super.key, required this.product});
  final ProductModel product;

  @override
  Widget builder(
    BuildContext context,
    ManuProductDetailViewModel viewModel,
    Widget? child,
  ) {
   
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(title: 'Product detail'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMiddle,
                      ImageBuilder(
                        image: product.productImage.first,
                        height: screenWidth(context) * .7,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      verticalSpaceMiddle,
                      Text(
                        product.productName ?? '',
                        style: AppTextStyle.big,
                      ),
                      verticalSpaceSmall,
                      Text(
                        product.description ?? '',
                        style: AppTextStyle.h4Normal,
                        textAlign: TextAlign.justify,
                      ),
                      verticalSpaceMiddle,
                      const Text('More Details', style: AppTextStyle.h2Bold),
                      verticalSpaceSmall,
                      if (product.description != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: product.details!
                              .map(
                                (e) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: smallSize),
                                  child: Row(
                                    children: [
                                      horizontalSpaceSmall,
                                      Container(
                                        height: tinySize,
                                        width: tinySize,
                                        decoration: const BoxDecoration(
                                          color: kcDarkGreyColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      horizontalSpaceSmall,
                                      Flexible(
                                        child: Text(
                                          e,
                                          style: AppTextStyle.h3Normal,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                     
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      
    );
  }


 @override
  ManuProductDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ManuProductDetailViewModel();
}

 
