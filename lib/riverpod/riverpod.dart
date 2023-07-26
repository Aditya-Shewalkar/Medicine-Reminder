import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicine_reminder/modules/add_medicine/add_medicine_screen.dart';
import 'package:medicine_reminder/modules/add_medicine/repo/add_medicine_repo.dart';
import 'package:medicine_reminder/modules/home/repo/home_screen_repo.dart';

final homeScreenProvider =
    ChangeNotifierProvider<HomeScreenRepo>((ref) => HomeScreenRepo());
final addMedicineProvider =
    ChangeNotifierProvider<AddMedicineRepo>((ref) => AddMedicineRepo());
