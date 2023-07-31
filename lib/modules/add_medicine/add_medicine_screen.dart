import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:medicine_reminder/api/notifications.dart';
import 'package:medicine_reminder/constants/colors.dart';
import 'package:medicine_reminder/modules/home/models/med_time.dart';
import 'package:medicine_reminder/modules/home/models/medicine.dart';
import 'package:medicine_reminder/riverpod/riverpod.dart';
import 'package:medicine_reminder/utils/utils.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Notificationapi.init();
  }

  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final addMedLogic = ref.watch(addMedicineProvider);
        final homeScreenLogic = ref.watch(homeScreenProvider);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              "Add Medicine",
              style: TextStyle(fontFamily: "PS", fontSize: 18),
            ),
          ),
          bottomNavigationBar: ElevatedButton(
              onPressed: () async {
                Medicine m1 = Medicine(
                    name: addMedLogic.medNameController.text.trim(),
                    type: addMedLogic.selectedMedType,
                    quantity: int.tryParse(
                        addMedLogic.medAmountController.text.trim()));
                MedTime mt1 = MedTime(
                  dateTime: DateTime(
                      addMedLogic.pickedDate!.year,
                      addMedLogic.pickedDate!.month,
                      addMedLogic.pickedDate!.day,
                      addMedLogic.pickedTime!.hour,
                      addMedLogic.pickedTime!.minute),
                );
                await addMedLogic.createReminder(m1, mt1);
                await homeScreenLogic.getMedDetails(DateTime.now());
                if (context.mounted) Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add Reminder",
                  style: TextStyle(fontFamily: "PM", fontSize: 18),
                ),
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
                    min: 1,
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Medicine Type:",
                    style: TextStyle(fontFamily: "PM", fontSize: 18),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LazyLoadScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              addMedLogic.changeMedType(
                                  addMedLogic.medTypeList[index].medTypeName);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    border: Border.all(
                                        color: (addMedLogic.medTypeList[index]
                                                    .medTypeName ==
                                                addMedLogic.selectedMedType)
                                            ? AppColor.primaryColor
                                            : AppColor.whiteColor)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image(
                                            fit: BoxFit.scaleDown,
                                            image: AssetImage(addMedLogic
                                                .medTypeList[index].img)),
                                      ),
                                    ),
                                    Text(
                                      addMedLogic
                                          .medTypeList[index].medTypeName,
                                      style: const TextStyle(
                                          fontFamily: "PS", fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    onEndOfPage: () {},
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Select Date"),
                          ElevatedButton(
                            onPressed: () async {
                              await addMedLogic.selectDate(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 5),
                              child: Text.rich(TextSpan(
                                  text:
                                      "${Utilities.formatDate(addMedLogic.pickedDate ?? DateTime.now())}   ",
                                  style: const TextStyle(fontSize: 16),
                                  children: const [
                                    WidgetSpan(
                                        child: Icon(Icons.calendar_month)),
                                  ])),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Select Time"),
                          ElevatedButton(
                              onPressed: () async {
                                await addMedLogic.selectTime(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 5),
                                child: Text.rich(TextSpan(
                                    text:
                                        "${Utilities.formatTime(addMedLogic.pickedTime ?? TimeOfDay.now())}   ",
                                    style: const TextStyle(fontSize: 16),
                                    children: const [
                                      WidgetSpan(
                                          child: Icon(
                                        Icons.timer,
                                      ))
                                    ])),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
