import 'package:flutter/material.dart';

class AddMedicineRepo extends ChangeNotifier {
  TextEditingController medNameController = TextEditingController();
  TextEditingController medAmountController = TextEditingController();

  List<String> items = ['ml', 'mg', 'pills'];
  String selectedDropItem = 'ml';

  double sliderValue = 1;

  changeSliderValue(newVal) {
    sliderValue = newVal;
    print(sliderValue);
    notifyListeners();
  }
}
