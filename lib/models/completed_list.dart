//Internal Packages
import 'package:flutter/material.dart';

//Project Packages
import 'package:timesheet/models/list.dart';
import 'package:timesheet/widgets/checked_list_item.dart';

class CompletedList extends StatelessWidget {
  const CompletedList({
    super.key,
    required this.completedList,
  });

  final List<CompletedListItems> completedList;

  @override
  Widget build(context) {

    if (completedList.isEmpty) {
      return Center(
        child: Text(
          'You have no finished tasks!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          for (final item in completedList) 
          CheckedListItem(
            key: ObjectKey(item.id),
            text: item.item
          ),
        ],
      ),
    );
  }
}