//Internal Packages
import 'package:flutter/material.dart';

//Project Packages
import 'package:timesheet/models/list.dart';
import 'package:timesheet/widgets/checkable_list_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todoList,
  });

  final List<TodoListItems> todoList;

  @override
  Widget build(context) {

    if (todoList.isEmpty) {
      return Center(
        child: Text(
          'You have no new tasks!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          for (final item in todoList) 
          CheckableListItem(
            key: ObjectKey(item.id),
            text: item.item
          ),
        ],
      ),
    );
  }
}