//Internal Packages
import 'package:flutter/material.dart';

class TimesheetList extends StatelessWidget {
  const TimesheetList({
    required this.timeRange,
    required this.timesheetData,
    super.key
  });

  final String timeRange;
  final Map<String, String> timesheetData;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8)
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeRange,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium!
                  ),
                  TextFormField(
                    initialValue: (timesheetData[timeRange] != '') 
                      ? timesheetData[timeRange]
                      : null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                      labelText: 'Add Task',
                    ),
                    onSaved: (text) {
                      if (text != '' || text != null) {
                        timesheetData.update(timeRange, (value) => text!);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}