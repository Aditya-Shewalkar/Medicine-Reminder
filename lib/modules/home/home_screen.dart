import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicine_reminder/constants/colors.dart';
import 'package:medicine_reminder/db/db.dart';
import 'package:medicine_reminder/modules/add_medicine/add_medicine_screen.dart';
import 'package:medicine_reminder/riverpod/riverpod.dart';
import 'package:medicine_reminder/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

import 'models/medicine.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  /*void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final homeScreenLogic = ref.watch(homeScreenProvider);
    await homeScreenLogic.getMedDetails();
  }*/

  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final homeScreenLogic = ref.watch(homeScreenProvider);
        final addMedLogic = ref.watch(addMedicineProvider);
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              TableCalendar(
                onDaySelected: homeScreenLogic.changeFocusedDay,
                firstDay: DateTime.now(),
                currentDay: DateTime.now(),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                selectedDayPredicate: (day) =>
                    isSameDay(homeScreenLogic.focusedDay, day),
                calendarFormat: homeScreenLogic.calendarFormat,
                onFormatChanged: (format) {
                  homeScreenLogic.changeFormat(format);
                },
              ),
              Expanded(
                  child: AsyncLoader(
                initState: () async =>
                    {await homeScreenLogic.getMedDetails(DateTime.now())},
                renderError: ([error]) {
                  return Center(
                    child: Text(error.toString()),
                  );
                },
                renderLoad: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                renderSuccess: ({data}) {
                  //print(homeScreenLogic.reminderList.length);
                  return RefreshIndicator(
                    onRefresh: () async {
                      await homeScreenLogic.getMedDetails(
                        homeScreenLogic.focusedDay,
                      );
                    },
                    child: ListView.builder(
                      itemCount: homeScreenLogic.reminderList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.secondaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ListTile(
                                leading: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Image(
                                    fit: BoxFit.scaleDown,
                                    image: AssetImage(addMedLogic.getImage(
                                        homeScreenLogic
                                            .reminderList[index].type!)),
                                  ),
                                ),
                                title: Text(
                                    homeScreenLogic.reminderList[index].name!),
                                subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(Utilities.formatDate(homeScreenLogic
                                          .reminderList[index].dateTime!)),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(Utilities.formatTime(TimeOfDay(
                                          hour: homeScreenLogic
                                              .reminderList[index]
                                              .dateTime!
                                              .hour,
                                          minute: homeScreenLogic
                                              .reminderList[index]
                                              .dateTime!
                                              .minute)))
                                    ]),
                                trailing: Text.rich(
                                    textAlign: TextAlign.center,
                                    TextSpan(
                                        text:
                                            "${homeScreenLogic.reminderList[index].quantity}\n",
                                        children: [
                                          TextSpan(
                                              text: homeScreenLogic.typeMap[
                                                  homeScreenLogic
                                                      .reminderList[index]
                                                      .type]),
                                        ])),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ))
            ],
          )),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMedicineScreen(),
                    ));
              },
              label: const Text("Add Medicine")),
        );
      },
    );
  }
}
