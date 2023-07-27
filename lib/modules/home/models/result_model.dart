import 'package:medicine_reminder/modules/home/models/med_time.dart';
import 'package:medicine_reminder/modules/home/models/medicine.dart';

class ResultModel {
  int? medTimeId;
  DateTime? dateTime;
  int? fk;
  int? medicineid;
  String? name;
  String? type;
  int? quantity;
  ResultModel(
      {this.medicineid,
      this.medTimeId,
      required this.dateTime,
      required this.fk,
      required this.name,
      required this.quantity,
      required this.type});
      
  static ResultModel fromJson(json) => ResultModel(
      dateTime: json[MedTimeFields.dateTime],
      fk: json[MedTimeFields.fk],
      name: json[MedicineFields.name],
      quantity: json[MedicineFields.quantity],
      type: json[MedicineFields.type]);
}
