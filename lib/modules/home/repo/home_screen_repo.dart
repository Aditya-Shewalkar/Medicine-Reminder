import 'package:flutter/material.dart';
import 'package:medicine_reminder/db/db.dart';
import 'package:medicine_reminder/modules/home/models/medicine.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreenRepo extends ChangeNotifier {
  CalendarFormat calendarFormat = CalendarFormat.week;
  Medicine? med;

  changeFormat(format) {
    calendarFormat = format;
    notifyListeners();
  }

  getMedDetails(id) async {
    med = await MedicineDatabase.instance.readMedicine(id);
    notifyListeners();
  }
}
