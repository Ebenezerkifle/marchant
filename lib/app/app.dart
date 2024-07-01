import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:marchant/services/state_service/enrollment_state_service.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/onboarding_state_service.dart';
import 'package:marchant/services/state_service/orders_state_service.dart';
import 'package:marchant/services/common_services/phone_service_service.dart';
import 'package:marchant/services/state_service/post_state_service.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:marchant/services/state_service/request_status_service_service.dart';
import 'package:marchant/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:marchant/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:marchant/ui/views/home/home_view.dart';
import 'package:marchant/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:marchant/ui/views/onboarding/login/login_view.dart';
import 'package:marchant/ui/views/onboarding/signup/signup_view.dart';
import 'package:marchant/ui/views/onboarding/signup/choose_catagory/choose_catagory_view.dart';
import 'package:marchant/ui/views/home//category_list/category_list_view.dart';
import 'package:marchant/ui/views/home//product_detail/product_detail_view.dart';
import 'package:marchant/ui/views/cart/cart_view.dart';
import 'package:marchant/ui/bottom_sheets/cart/cart_sheet.dart';
import 'package:marchant/ui/views/home//side_bar/side_bar_view.dart';
import 'package:marchant/ui/views//my_orders/my_orders_view.dart';
import 'package:marchant/ui/bottom_sheets/filter/filter_sheet.dart';
import 'package:marchant/ui/views//landing/landing_view.dart';
import 'package:marchant/ui/views//profile/profile_view.dart';
import 'package:marchant/ui/views/manufacturer//manu_home/manu_home_view.dart';
import 'package:marchant/ui/views/manufacturer//post/post_view.dart';
import 'package:marchant/ui/views/sub_category/sub_category_view.dart';
import 'package:marchant/ui/views/company_profile/company_profile_view.dart';
import 'package:marchant/services/state_service/user_service.dart';

import 'package:marchant/ui/dialogs/file_view/file_view_dialog.dart';
import 'package:marchant/ui/views/onboarding/change_paswords/change_paswords_view.dart';
import 'package:marchant/ui/views/sub_category/sub_category_list/sub_category_list_view.dart';
import 'package:marchant/ui/views/profile/mydetail/mydetail_view.dart';
import 'package:marchant/ui/views/manufacturer/manu_home/manu_product_detail/manu_product_detail_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: ChooseCatagoryView),
    MaterialRoute(page: CategoryListView),
    MaterialRoute(page: ProductDetailView),
    MaterialRoute(page: CartView),
    MaterialRoute(page: SideBarView),
    MaterialRoute(page: MyOrdersView),
    MaterialRoute(page: LandingView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: ManuHomeView),
    MaterialRoute(page: PostView),
    MaterialRoute(page: SubCategoryView),
    MaterialRoute(page: CompanyProfileView),
    MaterialRoute(page: ChangePasswordView),
    MaterialRoute(page: SubCategoryListView),
    MaterialRoute(page: MydetailView),
    MaterialRoute(page: ManuProductDetailView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: OnboardingStateService),
    LazySingleton(classType: ProductStateService),
    LazySingleton(classType: CartStateService),
    LazySingleton(classType: LandingStateService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: EnrollmentStateService),
    LazySingleton(classType: PostStateService),
    LazySingleton(classType: OrderStateService),
    LazySingleton(classType: RequestStatusServiceService),
    LazySingleton(classType: PhoneServiceService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: CartSheet),
    StackedBottomsheet(classType: FilterSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: FileViewDialog),
// @stacked-dialog
  ],
)
class App {}
