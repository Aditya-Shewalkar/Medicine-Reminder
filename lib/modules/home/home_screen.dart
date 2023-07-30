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
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final homeScreenLogic = ref.watch(homeScreenProvider);
    await homeScreenLogic.getMedDetails();
  }

  Widget build(BuildContext context) {
    print("here2");
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final homeScreenLogic = ref.watch(homeScreenProvider);
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                calendarFormat: homeScreenLogic.calendarFormat,
                onFormatChanged: (format) {
                  homeScreenLogic.changeFormat(format);
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    await homeScreenLogic.getMedDetails();
                  },
                  child: const Text("Get Medicines")),
              Expanded(
                  child: AsyncLoader(
                initState: () async => {await homeScreenLogic.getMedDetails()},
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
                  return ListView.builder(
                    itemCount: homeScreenLogic.reminderList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(homeScreenLogic.reminderList[index].name!),
                        subtitle: Row(children: [
                          Text(Utilities.formatDate(
                              homeScreenLogic.reminderList[index].dateTime!)),
                        ]),
                      );
                    },
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
