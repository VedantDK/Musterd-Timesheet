//Internal Packages
import 'package:flutter/material.dart';

//External Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Project Packages
import 'package:timesheet/providers/lists.dart';

class CheckedListItem extends ConsumerStatefulWidget {
  const CheckedListItem({
    required this.text,
    super.key
  });

  final String text;

  @override
  ConsumerState<CheckedListItem> createState() {
    return _CheckedTodoItemState();
  }
}

class _CheckedTodoItemState extends ConsumerState<CheckedListItem> {

  var _done = true;

  void _setDone(bool? isChecked) {
    setState(() {
      ref.read(pendingListProvider.notifier).addItem(widget.text);
      _done = isChecked ?? true;
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