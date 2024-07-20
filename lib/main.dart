import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marchant/app/app.bottomsheets.dart';
import 'package:marchant/app/app.dialogs.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/firebase_options.dart';
import 'package:marchant/services/state_service/language_service.dart';
import 'package:marchant/services/state_service/snackbar_service.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kcDarkGreyColor),
  );
  // runApp(const MainApp());
  _run();
}

void _run() async {
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableLevels = [];
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('am')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: const MainApp(),
  ));
}

final _languageService = locator<LanguagesService>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    _rebuildAllChildrenOnLanguageChange(context);
    _languageService.changeLanguage(context, context.locale.languageCode);
    return MaterialApp(
      scaffoldMessengerKey: SnackBarService.scaffoldKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: kcWhite),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}

_rebuildAllChildrenOnLanguageChange(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}
