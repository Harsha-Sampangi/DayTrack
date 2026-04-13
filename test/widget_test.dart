// This is a basic Flutter widget test.
// Tests can be added here as the app matures.

import 'package:flutter_test/flutter_test.dart';
import 'package:personal_life_manager/app.dart';

void main() {
  testWidgets('App starts without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Note: Full widget testing requires Hive to be initialized,
    // which needs additional test setup. This is a placeholder.
    expect(const App(), isNotNull);
  });
}
