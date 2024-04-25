import 'package:marchant/services/state_service/onboarding_state_service.dart';
import 'package:marchant/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:marchant/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:marchant/ui/views/home/home_view.dart';
import 'package:marchant/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:marchant/ui/views/onboarding/login/login_view.dart';
import 'package:marchant/ui/views/onboarding/signup/signup_view.dart';
import 'package:marchant/ui/views/onboarding/signup/signup_final/signup_final_view.dart';
import 'package:marchant/ui/views/signup//choose_catagory/choose_catagory_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: SignupFinalView),
    MaterialRoute(page: ChooseCatagoryView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: OnboardingStateService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
