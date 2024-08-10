//Internal Packages
import 'package:flutter/material.dart';

//External Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Project Packages
//import 'package:timesheet/screens/todo_screens/pending_tasks_screen.dart';
import 'package:timesheet/models/pending_list.dart';
import 'package:timesheet/providers/lists.dart';

class PendingTasksScreen extends ConsumerStatefulWidget {
  const PendingTasksScreen({super.key});

  @override
  ConsumerState<PendingTasksScreen> createState() => _PendingTasksScreenState();
}

class _PendingTasksScreenState extends ConsumerState<PendingTasksScreen> {
  late Future<void> _pendingListFuture;

  @override
  void initState() {
    super.initState();
    _pendingListFuture = ref.read(pendingListProvider.notifier).loadPendingList();
  }

  @override
  Widget build(context) {
    final addedItems = ref.watch(pendingListProvider);

    return Scaffold(
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: FutureBuilder(future: _pendingListFuture, builder: (context, snapshot) => snapshot.connectionState == 
                ConnectionState.waiting ? const Center(child: CircularProgressIndicator()) : PendingList (
                  pendingList: addedItems,
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}