import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/enums/user_role.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:marchant/ui/views/manufacturer/manu_home/manu_home_view.dart';
import 'package:marchant/ui/views/manufacturer/post/post_view.dart';
import 'package:marchant/ui/views/manufacturer/profile/profile_view.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/cart_model.dart';
import '../../../services/state_service/cart_state_service.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_style.dart';
import '../cart/cart_view.dart';
import '../home/home_view.dart';
import '../my_orders/my_orders_view.dart';
import '../profile/profile_view.dart';
import 'widgets/bar_items.dart';

// class LandingViewModel extends IndexTrackingViewModel {
//   final _cartState = locator<CartStateService>();
//   final _landingService = locator<LandingStateService>();
//   final _userService = locator<UserService>();

//   @override
//   List<ListenableServiceMixin> get listenableServices =>
//       [_cartState, _landingService];

//   @override
//   int get currentIndex => _landingService.currentIndex;

//   @override
//   void setIndex(int value) {
//     _landingService.setIndex(value);
//   }

//   Map<String, CartModel> get cartItems => _cartState.cartItems;
//   // bool get retailor => _userService.user?.role == "Retailer";
// bool get isRetailor => _userService.user?.role == UserRole.retailor;

//   List<Widget> get manufacturorViews => const [
//         ManuHomeView(),
//         PostView(),
//         ManuProfileView(),
//       ];
//   List<BottomBarItem> get manufacturorerItems => [
//         const BottomBarItem(title: 'Home', icon: FontAwesomeIcons.house),
//         const BottomBarItem(title: 'Post', icon: FontAwesomeIcons.squarePlus),
//         const BottomBarItem(title: 'Profile', icon: FontAwesomeIcons.solidUser),
//       ];

//   List<Widget> get marchantViews => const [
//         HomeView(),
//         CartView(),
//         MyOrdersView(),
//         ProfileView(),
//       ];

//   List<BottomBarItem> get marchantItems => [
//         const BottomBarItem(
//           title: ('Home'),
//           icon: FontAwesomeIcons.house,
//         ),
//         BottomBarItem(
//             title: ('Cart'),
//             icon: FontAwesomeIcons.cartShopping,
//             widget: (cartItems.isNotEmpty)
//                 ? Positioned(
//                     top: 0,
//                     child: Container(
//                       padding: const EdgeInsets.all(3),
//                       decoration: const BoxDecoration(
//                         color: kcPrimaryColorDark,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Text(
//                         cartItems.length.toString(),
//                         style: AppTextStyle.withColor(
//                             color: kcWhite, style: AppTextStyle.thinSmall),
//                       ),
//                     ),
//                   )
//                 : null),
//         const BottomBarItem(
//           title: ('My Orders'),
//           icon: FontAwesomeIcons.cartFlatbedSuitcase,
//         ),
//         const BottomBarItem(
//           title: ('Profile'),
//           icon: FontAwesomeIcons.solidUser,
//         ),
//       ];
// }





// import 'package:flutter/material.dart';
// import 'package:marchant/enums/user_role.dart';
// import 'package:marchant/services/state_service/landing_state_servic.dart';
// import 'package:marchant/services/state_service/user_service.dart';
// import 'package:stacked/stacked.dart';

// import '../../../app/app.locator.dart';
// import '../../../models/cart_model.dart';
// import '../../../services/state_service/cart_state_service.dart';
// import '../../common/app_colors.dart';
// import '../../common/app_text_style.dart';
// import '../cart/cart_view.dart';
// import '../home/home_view.dart';
// import '../my_orders/my_orders_view.dart';
// import '../profile/profile_view.dart';
// import '../manufacturer/manu_home/manu_home_view.dart';
// import '../manufacturer/post/post_view.dart';
// import '../manufacturer/profile/profile_view.dart';
// import 'widgets/bar_items.dart';




class LandingViewModel extends BaseViewModel {
  final _cartState = locator<CartStateService>();
  final _landingService = locator<LandingStateService>();

  Map<String, CartModel> get cartItems => _cartState.cartItems;

  UserRole get userRole => _landingService.userRole;

  List<Widget> get manufacturerViews => const [
        ManuHomeView(),
        PostView(),
        ManuProfileView(),
      ];

  List<BottomBarItem> get manufacturerItems => [
        const BottomBarItem(
          title: 'Home',
          icon: FontAwesomeIcons.house,
        ),
        const BottomBarItem(
          title: 'Post',
          icon: FontAwesomeIcons.squarePlus,
        ),
        const BottomBarItem(
          title: 'Profile',
          icon: FontAwesomeIcons.solidUser,
        ),
      ];

  List<Widget> get retailerViews => const [
        HomeView(),
        CartView(),
        MyOrdersView(),
        ProfileView(),
      ];

  List<BottomBarItem> get retailerItems => [
        const BottomBarItem(
          title: 'Home',
          icon: FontAwesomeIcons.house,
        ),
        BottomBarItem(
          title: 'Cart',
          icon: FontAwesomeIcons.cartShopping,
          widget: cartItems.isNotEmpty
              ? Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: kcPrimaryColorDark,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartItems.length.toString(),
                      style: AppTextStyle.withColor(
                        color: kcWhite,
                        style: AppTextStyle.thinSmall,
                      ),
                    ),
                  ),
                )
              : null,
        ),
        const BottomBarItem(
          title: 'My Orders',
          icon: FontAwesomeIcons.cartFlatbedSuitcase,
        ),
        const BottomBarItem(
          title: 'Profile',
          icon: FontAwesomeIcons.solidUser,
        ),
      ];

  List<Widget> get viewsToShow =>
      userRole == UserRole.manufacturer ? manufacturerViews : retailerViews;

  List<BottomBarItem> get itemsToShow =>
      userRole == UserRole.manufacturer ? manufacturerItems : retailerItems;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
