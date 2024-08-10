
class TimeIntervals {

  final intervals = [
    '0000', '0040', '0120',
    '0200', '0240', '0320',
    '0400', '0440', '0520',
    '0600', '0640', '0720',
    '0800', '0840', '0920',
    '1000', '1040', '1120',
    '1200', '1240', '1320',
    '1400', '1440', '1520',
    '1600', '1640', '1720',
    '1800', '1840', '1920',
    '2000', '2040', '2120',
    '2200', '2240', '2320'
  ];

  String timeConvert(String hhmm) {
    var split = hhmm.split('');
    var ampm = 'AM';
    var hour = split[0] + split[1];
    var mins = split[2] + split[3];

    if (int.parse(hour) >= 12) {
      ampm = 'PM';
    }
    
    if (int.parse(hour) >= 13) {
      hour = (int.parse(hour) - 12).toString().padLeft(2, '0');
      ampm = 'PM';
    }

    if (int.parse(hour) == 00) {
      hour = '12';
    }

    var time = ('$hour:$mins $ampm').toString();

    return time;
  }

  (List<String>, Map<String, String>) getTimeIntervals(time) {
    List<String> timeIntervals = [];
    List<String> lowerRange = [];
    List<String> upperRange = [];   

    int punchIn = time;
    int startIndex = 0;

    if(punchIn >= 2300) {
    startIndex = intervals.length - 1;
    }
    else {
      for(var index = 0; index < (intervals.length - 1); index++) {
        if (punchIn >= int.parse(intervals[index]) && punchIn < int.parse(intervals[index+1])) {
          startIndex = index;
        }
      }
    }
  
    List<String> split1 = intervals.sublist(startIndex);
    List<String> split2 = intervals.sublist(0, startIndex);
    lowerRange = split1 + split2;

    List<String> split3 = intervals.sublist(startIndex + 1);
    List<String> split4 = intervals.sublist(0, startIndex + 1);
    upperRange = split3 + split4;
    
    for(var i = 0; i < intervals.length; i++) {
      timeIntervals.insert(i, '${timeConvert(lowerRange[i])} - ${timeConvert(upperRange[i])}');
    }

    Map<String, String> timesheetData = {for (var item in timeIntervals) item : ''};

    return (timeIntervals, timesheetData);
  }
}