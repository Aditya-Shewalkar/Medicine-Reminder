String medicineTable = 'Medicine';

class MedicineFields {
  static final List<String> values = [id, name, type, quantity];
  static const String id = '_id';
  static const String name = 'name';
  static const String type = 'type';
  static const String quantity = 'quantity';
}

class Medicine {
  int? id;
  String? name;
  String? type;
  int? quantity;

  Medicine(
      {required this.id,
      required this.name,
      required this.type,
      required this.quantity});

  Map<String, Object?> toJson() => {
        MedicineFields.id: id,
        MedicineFields.name: name,
        MedicineFields.quantity: quantity,
        MedicineFields.type: type
      };

  static Medicine fromJson(Map<String, Object?> json) => Medicine(
      id: json[MedicineFields.id] as int?,
      name: json[MedicineFields.name] as String,
      type: json[MedicineFields.type] as String,
      quantity: json[MedicineFields.quantity] as int);
}
