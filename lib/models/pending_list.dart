//Internal Packages
import 'package:flutter/material.dart';

//Project Packages
import 'package:timesheet/models/list.dart';
import 'package:timesheet/widgets/checkable_list_item.dart';

class PendingList extends StatelessWidget {
  const PendingList({
    super.key,
    required this.pendingList,
  });

  final List<PendingListItems> pendingList;

  @override
  Widget build(context) {

    if (pendingList.isEmpty) {
      return Center(
        child: Text(
          'You have no pending tasks!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          for (final item in pendingList) 
          CheckableListItem(
            key: ObjectKey(item.id),
            text: item.item
          ),
        ],
      ),
    );
  }
}