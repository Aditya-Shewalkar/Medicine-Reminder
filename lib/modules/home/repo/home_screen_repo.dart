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
    List<ResultModel> tempList = <ResultModel>[];
    for (int i = 0; i < reminderList.length; i++) {
      //print(DateTime.now());
      //print("rl-");
      //print(reminderList[i].dateTime);
      if (DateTime.now().compareTo(reminderList[i].dateTime!) <= 0) {
        tempList.add(reminderList[i]);
      }
    }
    reminderList = tempList;
    notifyListeners();
  }
}
