import 'package:flutter/material.dart';
import 'package:medicine_reminder/db/db.dart';
import 'package:medicine_reminder/modules/home/models/medicine.dart';
import 'package:medicine_reminder/modules/home/models/result_model.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreenRepo extends ChangeNotifier {
  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime focusedDay = DateTime.now();
  List<ResultModel> reminderList = <ResultModel>[];

  changeFormat(format) {
    calendarFormat = format;
    notifyListeners();
  }

  changeFocusedDay(DateTime selected, DateTime focused) async {
    print(selected);
    print(focusedDay);
    focusedDay = selected;
    await getMedDetails(selected);
    print(focusedDay);
    notifyListeners();
  }

  getMedDetails(DateTime selected) async {
    reminderList = await MedicineDatabase.instance.getListOfMeds();
    //print(selected);
    //print(focused);
    List<ResultModel> tempList = <ResultModel>[];
    for (int i = 0; i < reminderList.length; i++) {
      //print(DateTime.now());
      //print("rl-");
      //print(reminderList[i].dateTime);
      if (reminderList[i].dateTime!.day == selected.day &&
          reminderList[i].dateTime!.month == selected.month &&
          reminderList[i].dateTime!.year == selected.year) {
        if (selected.day == DateTime.now().day &&
            selected.year == DateTime.now().year &&
            selected.month == DateTime.now().month) {
          if (DateTime.now().compareTo(reminderList[i].dateTime!) <= 0) {
            tempList.add(reminderList[i]);
          }
        } else {
          tempList.add(reminderList[i]);
        }
      }
    }
    reminderList = tempList;
    notifyListeners();
  }
}
