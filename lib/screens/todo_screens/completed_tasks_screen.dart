//Internal Packages
import 'package:flutter/material.dart';

//External Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Project Packages
import 'package:timesheet/models/completed_list.dart';
import 'package:timesheet/providers/lists.dart';

class CompletedTasksScreen extends ConsumerStatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  ConsumerState<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends ConsumerState<CompletedTasksScreen> {
  late Future<void> _completedListFuture;

  @override
  void initState() {
    super.initState();
    _completedListFuture = ref.read(completedListProvider.notifier).loadCompletedList();
  }

  @override
  Widget build(context) {
    final addedItems = ref.watch(completedListProvider);

    return Scaffold(
      body: Expanded(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: FutureBuilder(future: _completedListFuture, builder: (context, snapshot) => snapshot.connectionState == 
                ConnectionState.waiting ? const Center(child: CircularProgressIndicator()) : CompletedList (
                  completedList: addedItems,
                )
              ),
            ),
          ]
        ),
      ),
    );
  }
}