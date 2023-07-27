const String medTimeTable = 'medTimeTable';

class MedTimeFields {
  static final List<String> values = [id, dateTime, fk];
  static const String id = '_id';
  static const String dateTime = 'dateTime';
  static const String fk = 'fk';
}

class MedTime {
  int? id;
  DateTime? dateTime;
  int? fk;
  MedTime({this.id, required this.dateTime, required this.fk});

  Map<String, Object?> toJson() => {
        MedTimeFields.id: id,
        MedTimeFields.dateTime: dateTime!.toIso8601String(),
        MedTimeFields.fk: fk
      };

  static MedTime fromJson(Map<String, Object?> json) => MedTime(
      id: json[MedTimeFields.id] as int,
      dateTime: DateTime.parse(json[MedTimeFields.dateTime] as String),
      fk: json[MedTimeFields.fk] as int);
}
