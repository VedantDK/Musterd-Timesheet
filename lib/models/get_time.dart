//Internal Packages
import 'package:flutter/material.dart';

//External Packages
import 'package:intl/intl.dart';

//Project Packages
import 'package:timesheet/models/alerts.dart';
import 'package:timesheet/models/time_intervals.dart';

class GetTime {
  
  var dateFormat = DateFormat('dd-MM-yy HHmm');

  List<String> getDateTime() {
    var dateString = dateFormat.format(DateTime.now());
    var splitDate = dateString.split(' ');
    return splitDate;
  }

  Future<List<String>> getTime(String inTime, String outTime, String item, BuildContext context) async {
    var time = getDateTime()[1];
    var currentTime = TimeIntervals().timeConvert(time);
    List<String> timeState = [];

    if (item == 'inTime') {
      if (inTime != ' ') {
        bool confirm = await Alerts().repeatPunch('punch-in', context);
        
        if(confirm){
          timeState = [currentTime, item];
        }
      } else {
        timeState = [currentTime, item];
      }
    } else if (item == 'outTime'){
      if (inTime == ' ') {
        Alerts().emptyInOut('punch-in', context);
      } else if (outTime != ' ') { 
        bool confirm = await Alerts().repeatPunch('punch-out', context);
        
        if(confirm){
          timeState = [currentTime, item];
        }        
      } else {
        timeState = [currentTime, item];
      }
    }
    return timeState;
  }
}