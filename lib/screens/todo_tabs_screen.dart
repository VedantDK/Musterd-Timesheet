//Internal Packages
import 'package:flutter/material.dart';

//Project Packages
import 'package:timesheet/widgets/appbar_title.dart';
import 'package:timesheet/screens/todo_screens/todo_list_screen.dart';
import 'package:timesheet/screens/todo_screens/pending_tasks_screen.dart';
import 'package:timesheet/screens/todo_screens/completed_tasks_screen.dart';

class TodoScreen extends StatefulWidget{
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int selectedPageIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(context) {

    var activePageTitle = 'To-Do List';
    Widget activePage = const TodoListScreen();

    if (selectedPageIndex == 1) {
      activePageTitle = 'Pending Tasks';
      activePage = const PendingTasksScreen(); 
    }
    else if (selectedPageIndex == 2) {
      activePageTitle = 'Completed Tasks';
      activePage = const CompletedTasksScreen();
    }    

    return Scaffold(
      appBar: AppBar(
        title: AppbarTitle(title: activePageTitle),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted_add),label: "To-Do List"),
          BottomNavigationBarItem(icon: Icon(Icons.pending_actions_outlined),label: "Pending Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.task_outlined),label: "Completed Tasks"),
        ],
      ),
    );
  }
}