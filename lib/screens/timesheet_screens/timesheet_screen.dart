//Internal Packages
import 'package:flutter/material.dart';

//Project Packages
import 'package:timesheet/models/alerts.dart';
import 'package:timesheet/models/time_intervals.dart';
import 'package:timesheet/screens/todo_screens/todo_list_screen.dart';
import 'package:timesheet/widgets/timesheet_list.dart';
import 'package:timesheet/models/get_time.dart';

class TimesheetScreen extends StatefulWidget{
  const TimesheetScreen({super.key});

  @override
  State<TimesheetScreen> createState() => _TimesheetScreenState();
}

class _TimesheetScreenState extends State<TimesheetScreen> {

  String inTime = ' ';
  String outTime = ' ';
  final _timesheetFormKey = GlobalKey<FormState>();
  List<String> timeIntervals = [];
  Map<String, String> timesheetData = {};

  handleTimeState(String currentTime, String item) {
    if (item == 'inTime') {
      setState(() {
        inTime = currentTime;
      });
    } else if (item == 'outTime') {
      setState(() {
        outTime = currentTime;
      });
    }
  }

  submitPressed() {
    if (outTime == ' ') {
      Alerts().emptyInOut('punch-out', context);
    } else {
      setState(() {
        _timesheetFormKey.currentState!.reset();
        inTime = ' ';
        outTime = ' ';
        timeIntervals = [];
        timesheetData = {};
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data Submitted Successfully')
        )
      );
      const TodoListScreen();
    }
  }

   savePressed() {
     _timesheetFormKey.currentState!.save();
   }

  createTimeIntervals() {
    var hhmm = GetTime().getDateTime()[1];
    timeIntervals = TimeIntervals().getTimeIntervals(int.parse(hhmm)).$1;
    timesheetData = TimeIntervals().getTimeIntervals(int.parse(hhmm)).$2;
  }

  @override
  Widget build(context) {  
    Widget content = Center(
      child: Text(
        'Add Punch-in Time.',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer
        ),
      ),
    );

    if(timeIntervals.isNotEmpty){
      content = Form(
        key: _timesheetFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(timeIntervals.length, (index){
                return TimesheetList(timeRange: timeIntervals[index], timesheetData: timesheetData);
            }),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        List<String> timeState = await GetTime().getTime(inTime, outTime, 'inTime', context);
                        handleTimeState(timeState[0], timeState[1]);
                        createTimeIntervals();
                      },
                      icon: const Icon(Icons.input_rounded),
                      label: const Text('Punch in'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        List<String> timeState = await GetTime().getTime(inTime, outTime, 'outTime', context);
                        handleTimeState(timeState[0], timeState[1]);
                      },
                      icon: const Icon(Icons.output_rounded),
                      label: const Text('Punch out'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),  
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight, 
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Date :',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            GetTime().getDateTime()[0],
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'In Time :',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer
                            )
                          ),
                          const SizedBox(width: 8),
                          Text(
                            inTime,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Out Time :',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer
                            )
                          ),
                          const SizedBox(width: 8),
                          Text(
                            outTime,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Container (
                height: MediaQuery.of(context).size.height - 333,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),  
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight, 
                    ),
                    borderRadius: BorderRadius.circular(10)
                 ),
                child: content
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: savePressed,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Save'),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: submitPressed,
                  icon: const Icon(Icons.save_alt_outlined),
                  label: const Text('Submit'),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}