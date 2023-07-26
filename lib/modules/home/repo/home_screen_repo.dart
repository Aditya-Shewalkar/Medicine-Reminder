import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreenRepo extends ChangeNotifier {
  CalendarFormat calendarFormat = CalendarFormat.week;

  changeFormat(format) {
    calendarFormat = format;
    notifyListeners();
  }
}
