import 'package:flutter/material.dart';
import 'package:medicine_reminder/db/db.dart';
import 'package:medicine_reminder/modules/home/models/medicine.dart';
import 'package:medicine_reminder/modules/home/models/result_model.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreenRepo extends ChangeNotifier {
  CalendarFormat calendarFormat = CalendarFormat.week;
  List<ResultModel> reminderList = <ResultModel>[];

  changeFormat(format) {
    calendarFormat = format;
    notifyListeners();
  }

  getMedDetails() async {
    reminderList = await MedicineDatabase.instance.getListOfMeds();
    notifyListeners();
  }
}
