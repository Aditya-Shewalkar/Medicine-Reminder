import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicine_reminder/constants/colors.dart';
import 'package:medicine_reminder/modules/add_medicine/add_medicine_screen.dart';
import 'package:medicine_reminder/riverpod/riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              const Expanded(
                  child: SizedBox(
                height: 10,
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddMedicineScreen(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text.rich(TextSpan(
                              text: "Add Medicine   ",
                              style: TextStyle(fontFamily: 'PR', fontSize: 16),
                              children: [WidgetSpan(child: Icon(Icons.add))])),
                        ))
                  ],
                ),
              )
            ],
          )),
        );
      },
    );
  }
}
