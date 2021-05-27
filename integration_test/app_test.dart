import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:todos/modules/provider.dart';
import 'package:todos/ui/app/app.dart';
import 'package:todos/ui/screens/add_edit_screen/add_edit_screen.dart';
import 'package:todos/ui/screens/todo_list_screen/todo_list_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('run app', (tester) async {
    await tester.pumpWidget(Provider(
      create: (_) => AppProvider(),
      child: const App(),
    ));

    expect(find.byType(TodoListScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(AddEditScreen), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('title')), 'Прилететь в Иннополис');
    await tester.pump();
    await tester.enterText(find.byKey(const ValueKey('description')), 'Выступить на Мир.Труд.Мобайл!');
    await tester.pump();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(TodoListScreen), findsOneWidget);

    expect(find.text('Прилететь в Иннополис'), findsOneWidget);
    expect(find.text('Выступить на Мир.Труд.Мобайл!'), findsOneWidget);
  });
}
