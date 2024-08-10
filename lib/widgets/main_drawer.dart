//Internal Packages
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const  MainDrawer({
    required this.onSelectScreen,
    super.key,
  });

  final void Function(String identifier) onSelectScreen;
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),  
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight, 
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.apps_outlined, size: 40, color: Theme.of(context).colorScheme.primary,),
                  const SizedBox(width: 18),
                  Text(
                    "Hello!",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              )
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.format_list_bulleted_outlined,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "To-Do",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24,
              ),
            ),
            onTap: () {
              onSelectScreen("todo");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Timesheet",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24,
              ),
            ),
            onTap: () {
              onSelectScreen("timesheet");
            },
          ),
        ],
      ),
    );
  }
}