//Internal Packages
import 'package:flutter/material.dart';

//Project Packages
import 'package:timesheet/widgets/main_drawer.dart';
import 'package:timesheet/screens/todo_tabs_screen.dart';
import 'package:timesheet/screens/timesheet_screens/timesheet_screen.dart';
import 'package:timesheet/widgets/appbar_title.dart';

class UserLandingScreen extends StatelessWidget {
  const UserLandingScreen({super.key});
  
  @override
  Widget build(context) {
      
    void setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == "todo") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const TodoScreen(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(title: 'Welcome User'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      drawer: MainDrawer(onSelectScreen: setScreen),
      body: const TimesheetScreen(),
    );
  }
}