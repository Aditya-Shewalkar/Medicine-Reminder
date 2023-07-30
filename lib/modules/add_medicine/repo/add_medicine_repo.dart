import 'package:flutter/material.dart';
import 'package:medicine_reminder/constants/assets.dart';
import 'package:medicine_reminder/modules/home/models/med_time.dart';
import 'package:medicine_reminder/modules/home/models/medicine.dart';
import 'package:medicine_reminder/db/db.dart';

class AddMedicineRepo extends ChangeNotifier {
  TextEditingController medNameController = TextEditingController();
  TextEditingController medAmountController = TextEditingController();
  DateTime? pickedDate = DateTime.now();
  TimeOfDay? pickedTime = TimeOfDay.now();

  List<String> items = ['ml', 'mg', 'pills'];
  String selectedDropItem = 'ml';

  double sliderValue = 1;

  List<MedType> medTypeList = <MedType>[
    MedType(Images.capsulesImage, "Capsules"),
    MedType(Images.creamImage, "Cream"),
    MedType(Images.dropsImage, "Drops"),
    MedType(Images.pillsImage, "Pills"),
    MedType(Images.syringeImage, "Syringe"),
    MedType(Images.syrupImage, "Syrup")
  ];
  String selectedMedType = "Capsules";

  changeMedType(newVal) {
    selectedMedType = newVal;
    notifyListeners();
  }

  changeSliderValue(newVal) {
    sliderValue = newVal;
    notifyListeners();
  }

  createReminder(Medicine m1, MedTime mt1) async {
    await MedicineDatabase.instance.create(m1, mt1);
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: currentDate, // Set the range of allowable dates.
          lastDate: DateTime(currentDate.year +
              5), // You can customize this range according to your needs.
        ) ??
        DateTime.now();
    notifyListeners();
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay currentTime = TimeOfDay.now();

    pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    notifyListeners();
  }
}

class MedType {
  String img;
  String medTypeName;
  MedType(this.img, this.medTypeName);
}
