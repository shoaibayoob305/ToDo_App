import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_app/main.dart' as app;
import 'package:todo_app/screens/add_todo/add_todo.dart';
import 'package:todo_app/screens/home/home.dart';
import 'package:todo_app/screens/splash/splash.dart';

void main() {
  // final binding =
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('end to end test :', () {
    testWidgets(
      'tap on the floating action button, verify todo creation',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 5));
        // expect(find.byType(SplashScreen), findsOneWidget);
        // await tester.pump(const Duration(seconds: 4));
        // expect(find.byType(HomeScreen), findsOneWidget);

        // expect(find.byType(HomeScreen), findsOneWidget);
        // await tester.pumpAndSettle();

        await tester.tap(find.byType(FloatingActionButton));

        await tester.pumpAndSettle();
        // expect(find.byType(AddTodoScreen), findsOneWidget);
        await tester.enterText(find.byType(TextField).at(0), "Title");
        await tester.enterText(find.byType(TextField).at(1), "Description");
        await tester.tap(find.byType(TextField).at(2),);
        await tester.pumpAndSettle();
        await tester.tap(find.text('15')); // Select the 15th day, for example
        await tester.tap(find.text('OK')); 
        await tester.pumpAndSettle();

        await tester.tap(find.byType(MaterialButton));
        await tester.pumpAndSettle();
        expect(find.byType(HomeScreen), findsOneWidget);
      },
      // skip: false,
      // timeout: const Timeout(Duration(minutes: 5)),
    );
  });
}
