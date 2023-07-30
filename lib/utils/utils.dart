import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utilities {
  static String formatDate(DateTime date) {
    // Create a date format pattern to display only the date part
    final DateFormat formatter =
        DateFormat('yyyy-MM-dd'); // You can customize the format as needed

    // Format the DateTime object and return the formatted string
    return formatter.format(date);
  }

  static String formatTime(TimeOfDay time) {
    // Create a time format pattern to display only the time part
    final DateFormat formatter =
        DateFormat('HH:mm'); // You can customize the format as needed

    // Format the TimeOfDay object and return the formatted string
    return formatter.format(DateTime(
        2023, 1, 1, time.hour, time.minute)); // Use a fixed date for formatting
  }
}
