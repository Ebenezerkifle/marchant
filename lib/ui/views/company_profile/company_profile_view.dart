import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
import 'package:stacked/stacked.dart';
import './company_profile_viewmodel.dart';
import 'package:marchant/models/product_model.dart';

class CompanyProfileView extends StackedView<CompanyProfileViewModel> {
  const CompanyProfileView({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget builder(
    BuildContext context,
    CompanyProfileViewModel viewModel,
    Widget? child,
  )  {
    return Scaffold(
      key: viewModel.scaffoldKey,
      backgroundColor: kcWhite,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomeAppBar(title: 'CompanyProfile'),
              Text(
                product.provider??"Unkown Company",
                style:AppTextStyle.h1Bold,
              ),
              const SizedBox(height: mediumSize),
              const Text(
                'License Number: ABC12345',
                  style: AppTextStyle.h4Bold,
              ),
              const SizedBox(height: largeSize),
              const Text(
                'Products:',
                style: AppTextStyle.h2Bold,
              ),
              const SizedBox(height: mediumSize),
              verticalSpaceMedium,
              CustomeGrideWidget(
                widgets: viewModel.products.entries
                    .map(
                      (e) => CustomeCardWidget(
                        size: screenWidth(context) * .38,
                        title: e.value.title ?? '',
                        details: e.value.details ?? [],
                        detailLimit: 3,
                        image: e.value.images?.first ?? '',
                        widget: Text(
                          '${e.value.price} ETB',
                          style: AppTextStyle.h4Bold,
                        ),
                      ),
                    )
                    .toList(),
              ),
              verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }
  @override
  CompanyProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CompanyProfileViewModel();
}

// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
// import 'company_profile_viewmodel.dart';

// class CompanyProfileView extends StatelessWidget {
//   const CompanyProfileView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<CompanyProfileViewModel>.reactive(
//       viewModelBuilder: () => CompanyProfileViewModel(),
//       builder: (context, viewModel, child) {
//         return Scaffold(
//           backgroundColor: Theme.of(context).colorScheme.background,
//           body: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomeAppBar(
//                   title: 'Company Profile',
//                 ),
//                 const Text(
//                   'XYZ Company',
//                   // Replace with actual license number
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10.0),
//                 const Text(
//                   'License Number: ABC12345', // Replace with actual company name
//                   style: TextStyle(
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 50.0),
//                 const Text(
//                   'Products:',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10.0),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: viewModel.products
//                         .length, // Replace with actual product list length
//                     itemBuilder: (context, index) {
//                       final product = viewModel
//                           .products[index]; // Replace with actual product model
//                       return ListTile(
//                         leading: Container(
//                           height: 50.0,
//                           width: 50.0,
//                           decoration: BoxDecoration(
//                             color: Colors.grey, // Placeholder color
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           // Replace the child widget with the product image
//                           child:
//                               Placeholder(), // Placeholder for the product image
//                         ),
//                         title: Text(
//                             product.name), // Replace with actual product name
//                         subtitle: Text(product
//                             .description), // Replace with actual product description
//                         // Add onTap function to navigate to product details page
//                         onTap: () {
//                           // Navigate to product details page
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
