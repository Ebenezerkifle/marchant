// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/state_service/cart_state_service.dart';
import '../services/state_service/enrollment_state_service.dart';
import '../services/state_service/landing_state_servic.dart';
import '../services/state_service/onboarding_state_service.dart';
import '../services/state_service/orders_state_service.dart';
import '../services/state_service/post_state_service.dart';
import '../services/state_service/product_state_service.dart';
import '../services/state_service/user_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => OnboardingStateService());
  locator.registerLazySingleton(() => ProductStateService());
  locator.registerLazySingleton(() => CartStateService());
  locator.registerLazySingleton(() => LandingStateService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => EnrollmentStateService());
  locator.registerLazySingleton(() => PostStateService());
  locator.registerLazySingleton(() => OrderStateService());
}
