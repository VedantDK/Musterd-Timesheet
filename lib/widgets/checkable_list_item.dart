//Internal Packages
import 'package:flutter/material.dart';

//External Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Project Packages
import 'package:timesheet/providers/lists.dart';

class CheckableListItem extends ConsumerStatefulWidget {
  const CheckableListItem({
    required this.text,
    super.key
  });

  final String text;

  @override
  ConsumerState<CheckableListItem> createState() {
    return _CheckableTodoItemState();
  }
}

class _CheckableTodoItemState extends ConsumerState<CheckableListItem> {

  var _done = false;

  void _setDone(bool? isChecked) {
    setState(() {
      //ref.read(completedListProvider.notifier).addItem(widget.text);
      _done = isChecked ?? false;
    });
  }

  @override
  Widget build(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 10),
        Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer
          ),
        ),
        const Spacer(),
        Checkbox(value: _done, onChanged: _setDone),
      ],
    );
  }
}