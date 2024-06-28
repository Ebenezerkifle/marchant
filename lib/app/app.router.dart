// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i20;
import 'package:flutter/material.dart';
import 'package:marchant/models/category_model.dart' as _i23;
import 'package:marchant/models/order_model.dart' as _i22;
import 'package:marchant/models/product_model.dart' as _i21;
import 'package:marchant/ui/views/cart/cart_view.dart' as _i9;
import 'package:marchant/ui/views/company_profile/company_profile_view.dart'
    as _i17;
import 'package:marchant/ui/views/home/category_list/category_list_view.dart'
    as _i7;
import 'package:marchant/ui/views/home/home_view.dart' as _i2;
import 'package:marchant/ui/views/home/product_detail/product_detail_view.dart'
    as _i8;
import 'package:marchant/ui/views/home/side_bar/side_bar_view.dart' as _i10;
import 'package:marchant/ui/views/landing/landing_view.dart' as _i12;
import 'package:marchant/ui/views/manufacturer/manu_home/manu_home_view.dart'
    as _i14;
import 'package:marchant/ui/views/manufacturer/post/post_view.dart' as _i15;
import 'package:marchant/ui/views/my_orders/my_orders_view.dart' as _i11;
import 'package:marchant/ui/views/onboarding/change_paswords/change_paswords_view.dart'
    as _i18;
import 'package:marchant/ui/views/onboarding/login/login_view.dart' as _i4;
import 'package:marchant/ui/views/onboarding/signup/choose_catagory/choose_catagory_view.dart'
    as _i6;
import 'package:marchant/ui/views/onboarding/signup/signup_view.dart' as _i5;
import 'package:marchant/ui/views/profile/profile_view.dart' as _i13;
import 'package:marchant/ui/views/startup/startup_view.dart' as _i3;
import 'package:marchant/ui/views/sub_category/sub_category_list/sub_category_list_view.dart'
    as _i19;
import 'package:marchant/ui/views/sub_category/sub_category_view.dart' as _i16;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i24;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const loginView = '/login-view';

  static const signupView = '/signup-view';

  static const chooseCatagoryView = '/choose-catagory-view';

  static const categoryListView = '/category-list-view';

  static const productDetailView = '/product-detail-view';

  static const cartView = '/cart-view';

  static const sideBarView = '/side-bar-view';

  static const myOrdersView = '/my-orders-view';

  static const landingView = '/landing-view';

  static const profileView = '/profile-view';

  static const manuHomeView = '/manu-home-view';

  static const postView = '/post-view';

  static const subCategoryView = '/sub-category-view';

  static const companyProfileView = '/company-profile-view';

  static const changePasswordView = '/change-password-view';

  static const subCategoryListView = '/sub-category-list-view';

  static const all = <String>{
    homeView,
    startupView,
    loginView,
    signupView,
    chooseCatagoryView,
    categoryListView,
    productDetailView,
    cartView,
    sideBarView,
    myOrdersView,
    landingView,
    profileView,
    manuHomeView,
    postView,
    subCategoryView,
    companyProfileView,
    changePasswordView,
    subCategoryListView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i4.LoginView,
    ),
    _i1.RouteDef(
      Routes.signupView,
      page: _i5.SignupView,
    ),
    _i1.RouteDef(
      Routes.chooseCatagoryView,
      page: _i6.ChooseCatagoryView,
    ),
    _i1.RouteDef(
      Routes.categoryListView,
      page: _i7.CategoryListView,
    ),
    _i1.RouteDef(
      Routes.productDetailView,
      page: _i8.ProductDetailView,
    ),
    _i1.RouteDef(
      Routes.cartView,
      page: _i9.CartView,
    ),
    _i1.RouteDef(
      Routes.sideBarView,
      page: _i10.SideBarView,
    ),
    _i1.RouteDef(
      Routes.myOrdersView,
      page: _i11.MyOrdersView,
    ),
    _i1.RouteDef(
      Routes.landingView,
      page: _i12.LandingView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i13.ProfileView,
    ),
    _i1.RouteDef(
      Routes.manuHomeView,
      page: _i14.ManuHomeView,
    ),
    _i1.RouteDef(
      Routes.postView,
      page: _i15.PostView,
    ),
    _i1.RouteDef(
      Routes.subCategoryView,
      page: _i16.SubCategoryView,
    ),
    _i1.RouteDef(
      Routes.companyProfileView,
      page: _i17.CompanyProfileView,
    ),
    _i1.RouteDef(
      Routes.changePasswordView,
      page: _i18.ChangePasswordView,
    ),
    _i1.RouteDef(
      Routes.subCategoryListView,
      page: _i19.SubCategoryListView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.LoginView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginView(),
        settings: data,
      );
    },
    _i5.SignupView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SignupView(),
        settings: data,
      );
    },
    _i6.ChooseCatagoryView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ChooseCatagoryView(),
        settings: data,
      );
    },
    _i7.CategoryListView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.CategoryListView(),
        settings: data,
      );
    },
    _i8.ProductDetailView: (data) {
      final args = data.getArgs<ProductDetailViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.ProductDetailView(key: args.key, product: args.product),
        settings: data,
      );
    },
    _i9.CartView: (data) {
      final args = data.getArgs<CartViewArguments>(
        orElse: () => const CartViewArguments(),
      );
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.CartView(key: args.key, order: args.order),
        settings: data,
      );
    },
    _i10.SideBarView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.SideBarView(),
        settings: data,
      );
    },
    _i11.MyOrdersView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.MyOrdersView(),
        settings: data,
      );
    },
    _i12.LandingView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.LandingView(),
        settings: data,
      );
    },
    _i13.ProfileView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.ProfileView(),
        settings: data,
      );
    },
    _i14.ManuHomeView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.ManuHomeView(),
        settings: data,
      );
    },
    _i15.PostView: (data) {
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.PostView(),
        settings: data,
      );
    },
    _i16.SubCategoryView: (data) {
      final args = data.getArgs<SubCategoryViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.SubCategoryView(
            key: args.key,
            categoryValue: args.categoryValue,
            subSubCategoryValue: args.subSubCategoryValue),
        settings: data,
      );
    },
    _i17.CompanyProfileView: (data) {
      final args = data.getArgs<CompanyProfileViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i17.CompanyProfileView(key: args.key, product: args.product),
        settings: data,
      );
    },
    _i18.ChangePasswordView: (data) {
      final args = data.getArgs<ChangePasswordViewArguments>(
        orElse: () => const ChangePasswordViewArguments(),
      );
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i18.ChangePasswordView(key: args.key, forget: args.forget),
        settings: data,
      );
    },
    _i19.SubCategoryListView: (data) {
      final args = data.getArgs<SubCategoryListViewArguments>(nullOk: false);
      return _i20.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.SubCategoryListView(
            key: args.key,
            subCategories: args.subCategories,
            categoryValue: args.categoryValue),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ProductDetailViewArguments {
  const ProductDetailViewArguments({
    this.key,
    required this.product,
  });

  final _i20.Key? key;

  final _i21.ProductModel product;

  @override
  String toString() {
    return '{"key": "$key", "product": "$product"}';
  }

  @override
  bool operator ==(covariant ProductDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.product == product;
  }

  @override
  int get hashCode {
    return key.hashCode ^ product.hashCode;
  }
}

class CartViewArguments {
  const CartViewArguments({
    this.key,
    this.order,
  });

  final _i20.Key? key;

  final _i22.OrderModel? order;

  @override
  String toString() {
    return '{"key": "$key", "order": "$order"}';
  }

  @override
  bool operator ==(covariant CartViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.order == order;
  }

  @override
  int get hashCode {
    return key.hashCode ^ order.hashCode;
  }
}

class SubCategoryViewArguments {
  const SubCategoryViewArguments({
    this.key,
    required this.categoryValue,
    required this.subSubCategoryValue,
  });

  final _i20.Key? key;

  final String categoryValue;

  final String subSubCategoryValue;

  @override
  String toString() {
    return '{"key": "$key", "categoryValue": "$categoryValue", "subSubCategoryValue": "$subSubCategoryValue"}';
  }

  @override
  bool operator ==(covariant SubCategoryViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.categoryValue == categoryValue &&
        other.subSubCategoryValue == subSubCategoryValue;
  }

  @override
  int get hashCode {
    return key.hashCode ^ categoryValue.hashCode ^ subSubCategoryValue.hashCode;
  }
}

class CompanyProfileViewArguments {
  const CompanyProfileViewArguments({
    this.key,
    required this.product,
  });

  final _i20.Key? key;

  final _i21.ProductModel product;

  @override
  String toString() {
    return '{"key": "$key", "product": "$product"}';
  }

  @override
  bool operator ==(covariant CompanyProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.product == product;
  }

  @override
  int get hashCode {
    return key.hashCode ^ product.hashCode;
  }
}

class ChangePasswordViewArguments {
  const ChangePasswordViewArguments({
    this.key,
    this.forget = false,
  });

  final _i20.Key? key;

  final bool forget;

  @override
  String toString() {
    return '{"key": "$key", "forget": "$forget"}';
  }

  @override
  bool operator ==(covariant ChangePasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.forget == forget;
  }

  @override
  int get hashCode {
    return key.hashCode ^ forget.hashCode;
  }
}

class SubCategoryListViewArguments {
  const SubCategoryListViewArguments({
    this.key,
    required this.subCategories,
    this.categoryValue,
  });

  final _i20.Key? key;

  final List<_i23.Category> subCategories;

  final String? categoryValue;

  @override
  String toString() {
    return '{"key": "$key", "subCategories": "$subCategories", "categoryValue": "$categoryValue"}';
  }

  @override
  bool operator ==(covariant SubCategoryListViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.subCategories == subCategories &&
        other.categoryValue == categoryValue;
  }

  @override
  int get hashCode {
    return key.hashCode ^ subCategories.hashCode ^ categoryValue.hashCode;
  }
}

extension NavigatorStateExtension on _i24.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChooseCatagoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.chooseCatagoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCategoryListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.categoryListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductDetailView({
    _i20.Key? key,
    required _i21.ProductModel product,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.productDetailView,
        arguments: ProductDetailViewArguments(key: key, product: product),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCartView({
    _i20.Key? key,
    _i22.OrderModel? order,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.cartView,
        arguments: CartViewArguments(key: key, order: order),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSideBarView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.sideBarView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMyOrdersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.myOrdersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLandingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.landingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToManuHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.manuHomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPostView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.postView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSubCategoryView({
    _i20.Key? key,
    required String categoryValue,
    required String subSubCategoryValue,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.subCategoryView,
        arguments: SubCategoryViewArguments(
            key: key,
            categoryValue: categoryValue,
            subSubCategoryValue: subSubCategoryValue),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCompanyProfileView({
    _i20.Key? key,
    required _i21.ProductModel product,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.companyProfileView,
        arguments: CompanyProfileViewArguments(key: key, product: product),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangePasswordView({
    _i20.Key? key,
    bool forget = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.changePasswordView,
        arguments: ChangePasswordViewArguments(key: key, forget: forget),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSubCategoryListView({
    _i20.Key? key,
    required List<_i23.Category> subCategories,
    String? categoryValue,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.subCategoryListView,
        arguments: SubCategoryListViewArguments(
            key: key,
            subCategories: subCategories,
            categoryValue: categoryValue),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChooseCatagoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.chooseCatagoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCategoryListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.categoryListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProductDetailView({
    _i20.Key? key,
    required _i21.ProductModel product,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.productDetailView,
        arguments: ProductDetailViewArguments(key: key, product: product),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCartView({
    _i20.Key? key,
    _i22.OrderModel? order,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.cartView,
        arguments: CartViewArguments(key: key, order: order),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSideBarView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.sideBarView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMyOrdersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.myOrdersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLandingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.landingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithManuHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.manuHomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPostView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.postView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSubCategoryView({
    _i20.Key? key,
    required String categoryValue,
    required String subSubCategoryValue,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.subCategoryView,
        arguments: SubCategoryViewArguments(
            key: key,
            categoryValue: categoryValue,
            subSubCategoryValue: subSubCategoryValue),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCompanyProfileView({
    _i20.Key? key,
    required _i21.ProductModel product,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.companyProfileView,
        arguments: CompanyProfileViewArguments(key: key, product: product),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangePasswordView({
    _i20.Key? key,
    bool forget = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.changePasswordView,
        arguments: ChangePasswordViewArguments(key: key, forget: forget),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSubCategoryListView({
    _i20.Key? key,
    required List<_i23.Category> subCategories,
    String? categoryValue,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.subCategoryListView,
        arguments: SubCategoryListViewArguments(
            key: key,
            subCategories: subCategories,
            categoryValue: categoryValue),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
