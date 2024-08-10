//Internal Packages
import 'package:flutter/material.dart';

//External Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Project Packages
//import 'package:timesheet/screens/todo_screens/pending_tasks_screen.dart';
import 'package:timesheet/models/todo_list.dart';
import 'package:timesheet/providers/lists.dart';

class TodoListScreen extends ConsumerStatefulWidget {
  const TodoListScreen({super.key});

  @override
  ConsumerState<TodoListScreen> createState() { 
    return _TodoListScreenState();
  }
}

class _TodoListScreenState extends ConsumerState<TodoListScreen> {
  
  final _todoFormKey = GlobalKey<FormState>();
  var item = '';
  late Future<void> _todoListFuture;

  @override
  void initState() {
    super.initState();
    _todoListFuture = ref.read(todoListProvider.notifier).loadTodoList();
  }

  onAdd() {
    if(_todoFormKey.currentState!.validate()){
      setState(() {
        _todoFormKey.currentState!.save();
        ref.read(todoListProvider.notifier).addItem(item);
        _todoFormKey.currentState!.reset();
      });
    }
  }

  onSubmitPressed() {
    //ref.read(pendingListProvider.notifier).addItem(addedItems);
  }

  @override
  Widget build(context) {
    final addedItems = ref.watch(todoListProvider);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Form(
                  key: _todoFormKey,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                            labelText: 'Add Task',
                          ),
                          validator: (value) {
                            if (value == null ||
                            value.isEmpty) {
                              return 'Please add a task.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            item = value!;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: onAdd,
                        icon: const Icon(Icons.add),
                        label: const Text('Add')
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: FutureBuilder(future: _todoListFuture, builder: (context, snapshot) => snapshot.connectionState == 
                    ConnectionState.waiting ? const Center(child: CircularProgressIndicator()) : TodoList (
                      todoList: addedItems,
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}