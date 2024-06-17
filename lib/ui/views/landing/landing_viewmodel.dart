import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/enums/user_role.dart';
import 'package:marchant/services/state_service/enrollment_state_service.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:marchant/ui/views/manufacturer/manu_home/manu_home_view.dart';
import 'package:marchant/ui/views/manufacturer/post/post_view.dart';
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

class LandingViewModel extends IndexTrackingViewModel {
  final _cartState = locator<CartStateService>();
  final _landingService = locator<LandingStateService>();
  final _enrollmentService = locator<EnrollmentStateService>();
  final _userService = locator<UserService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_cartState, _landingService];

  @override
  int get currentIndex => _landingService.currentIndex;

  @override
  void setIndex(int value) {
    _landingService.setIndex(value);
  }

  Map<String, CartModel> get cartItems => _cartState.cartItems;
  bool get retailor => _enrollmentService.userRole == UserRole.retailor;

  String? role;

  landingViewModel() {
    fetchRole();
  }

  Future<void> fetchRole() async {
    role = _userService.user?.role;
    notifyListeners();
  }

  List<Widget> get manufacturorViews => const [
        ManuHomeView(),
        PostView(),
        ProfileView(),
      ];
  List<BottomBarItem> get manufacturorerItems => [
        const BottomBarItem(title: 'Home', icon: FontAwesomeIcons.house),
        const BottomBarItem(title: 'Post', icon: FontAwesomeIcons.squarePlus),
        const BottomBarItem(title: 'Profile', icon: FontAwesomeIcons.solidUser),
      ];

  List<Widget> get marchantViews => [
        HomeView(),
        CartView(),
        MyOrdersView(),
        ProfileView(),
      ];

  List<BottomBarItem> get marchantItems => [
        const BottomBarItem(
          title: ('Home'),
          icon: FontAwesomeIcons.house,
        ),
        BottomBarItem(
            title: ('Cart'),
            icon: FontAwesomeIcons.cartShopping,
            widget: (cartItems.isNotEmpty)
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
                            color: kcWhite, style: AppTextStyle.thinSmall),
                      ),
                    ),
                  )
                : null),
        const BottomBarItem(
          title: ('My Orders'),
          icon: FontAwesomeIcons.cartFlatbedSuitcase,
        ),
        const BottomBarItem(
          title: ('Profile'),
          icon: FontAwesomeIcons.solidUser,
        ),
      ];
}
