import 'package:flutter/material.dart';

class MyDateUtil {
  //get formatted time from millisecondsSinceEpoch string
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  //get last message time (used in chat user card)
  static String getLastMessageTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays > 0) {
      return '${date.day} ${getMonthName(date)} ${date.year}';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hours ago';
    } else {
      return TimeOfDay.fromDateTime(date).format(context);
    }
  }

  //get month name from month number
  static String getMonthName(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'Aug';
      case 9:
        return 'Sept';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      default:
        return 'Dec';
    }
  }
}
