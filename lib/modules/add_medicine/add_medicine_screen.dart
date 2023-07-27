import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicine_reminder/constants/colors.dart';
import 'package:medicine_reminder/modules/home/models/med_time.dart';
import 'package:medicine_reminder/modules/home/models/medicine.dart';
import 'package:medicine_reminder/riverpod/riverpod.dart';
import 'package:intl/intl.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final addMedLogic = ref.watch(addMedicineProvider);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Add Medicine",
              style: TextStyle(fontFamily: "PS", fontSize: 18),
            ),
          ),
          bottomNavigationBar: ElevatedButton(
              onPressed: () {
                Medicine m1 =
                    Medicine(name: "Crocin", type: "Pill", quantity: 2);
                MedTime mt1 =
                    MedTime(dateTime: DateTime(DateTime.now().hour + 3), fk: 1);
                addMedLogic.createReminder(m1, mt1);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Add Reminder"),
              )),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Medicine name",
                    ),
                    controller: addMedLogic.medNameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Medicine amount",
                            ),
                            controller: addMedLogic.medAmountController,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: DropdownButtonFormField(
                            value: addMedLogic.selectedDropItem,
                            items: addMedLogic.items
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              addMedLogic.selectedDropItem = newValue!;
                            }),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "How Long?",
                    style: TextStyle(fontFamily: 'PS', fontSize: 20),
                  ),
                ),
                Slider(
                    activeColor: AppColor.secondaryColor,
                    inactiveColor: AppColor.whiteColor,
                    thumbColor: AppColor.primaryColor,
                    value: addMedLogic.sliderValue,
                    min: 0,
                    max: 90,
                    //label: addMedLogic.sliderValue.round().toString(),
                    onChanged: (newValue) {
                      addMedLogic.changeSliderValue(newValue);
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text.rich(
                          textAlign: TextAlign.end,
                          TextSpan(
                              text: "${addMedLogic.sliderValue.round()} days")),
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(height: 10),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await addMedLogic.selectDate(context);
                      },
                      child: Text(
                          formatDate(addMedLogic.pickedDate ?? DateTime.now())),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

String formatDate(DateTime date) {
  // Create a date format pattern to display only the date part
  final DateFormat formatter =
      DateFormat('yyyy-MM-dd'); // You can customize the format as needed

  // Format the DateTime object and return the formatted string
  return formatter.format(date);
}
