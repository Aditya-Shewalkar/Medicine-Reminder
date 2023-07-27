import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicine_reminder/constants/colors.dart';
import 'package:medicine_reminder/db/db.dart';
import 'package:medicine_reminder/modules/add_medicine/add_medicine_screen.dart';
import 'package:medicine_reminder/riverpod/riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import 'models/medicine.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Medicine? med;

  @override
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
                    homeScreenLogic.getMedDetails(1);
                  },
                  child: const Text("Get Medicines")),
              Expanded(
                  child: AsyncLoader(
                initState: () async =>
                    {med = await homeScreenLogic.getMedDetails(1)},
                renderError: ([error]) {
                  return Center(
                    child: Text(error.toString()),
                  );
                },
                renderLoad: () {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                renderSuccess: ({data}) {
                  return Center(
                    child: Text(med!.name!),
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
                      builder: (context) => AddMedicineScreen(),
                    ));
              },
              label: Text("Add Medicine")),
        );
      },
    );
  }
}
