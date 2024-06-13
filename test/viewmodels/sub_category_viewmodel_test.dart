import 'package:flutter_test/flutter_test.dart';
import 'package:marchant/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('SubCategoryViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
