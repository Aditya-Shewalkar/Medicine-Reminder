// ignore: depend_on_referenced_packages
import 'package:medicine_reminder/modules/home/models/med_time.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../modules/home/models/medicine.dart';

class MedicineDatabase {
  static final MedicineDatabase instance = MedicineDatabase._init();

  MedicineDatabase._init();

  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDB('medicine.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $medicineTable (
        ${MedicineFields.id} ${idType},
        ${MedicineFields.name} ${textType},
        ${MedicineFields.quantity} ${integerType},
        ${MedicineFields.type} ${textType}
      )
      ''');

    await db.execute('''
  CREATE TABLE $medTimeTable (
    ${MedTimeFields.id} ${idType},
    ${MedTimeFields.dateTime} ${textType}
    ${MedTimeFields.fk} ${integerType}
    FOREIGN KEY(${MedTimeFields.fk})  REFERENCES ${medicineTable}(${MedicineFields.id})
  )
''');
  }

  Future<void> create(Medicine medicine, MedTime medTime) async {
    final db = await instance.getDatabase();
    final idMed = await db.insert(medicineTable, medicine.toJson());
    medTime.fk = idMed;
    final idTime = await db.insert(medTimeTable, medTime.toJson());
  }

  Future<Medicine> readMedicine(int id) async {
    final db = await getDatabase();
    final maps = await db.query(
      medicineTable,
      columns: MedicineFields.values,
      where: '${MedicineFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Medicine.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<MedTime>> readMedTime(int fk) async {
    final db = await getDatabase();
    final maps = await db.query(medTimeTable,
        columns: MedTimeFields.values,
        where: '${MedTimeFields.fk} = ?',
        whereArgs: [fk]);
    if (maps.isNotEmpty) {
      return maps.map((json) => MedTime.fromJson(json)).toList();
    } else {
      throw Exception('No Such FK exists');
    }
  }

  Future close() async {
    final db = await instance.getDatabase();
    db.close();
  }
}
