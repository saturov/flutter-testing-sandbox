import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/models/todo_entity.dart';
import 'package:todos/ui/widgets/todo_list_item/todo_list_item.dart';
import 'package:todos/ui/widgets/todo_list_item/todo_list_item_wm.dart';

import '../mocks/navigation_mock.dart';
import '../mocks/todos_repository_mock.dart';

void main() {
  group('Todo list item widget', () {
    final todoRepositoryMock = TodosRepositoryMock();
    const todo = TodoEntity(
      id: 0,
      title: 'title',
      description: 'description',
      isCompleted: false,
    );

    const todoCompleted = TodoEntity(
      id: 0,
      title: 'title',
      description: 'description',
      isCompleted: true,
    );

    testWidgets('TodoListItem init', (tester) async {
      when(() => todoRepositoryMock.getTodo(0)).thenReturn(todo);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoListItem(wmBuilder: (context) {
              return TodoListItemWM(
                NavigationMock(),
                todoRepositoryMock,
                0,
              );
            }),
          ),
        ),
      );

      expect(find.text('title'), findsOneWidget);

      await tester.tap(find.byType(Checkbox));

      verify(() => todoRepositoryMock.updateTodo(todoCompleted)).called(1);
    });
  });
}
