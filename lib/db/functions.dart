import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_app/model/student_model.dart';

class DBFunctions {
  Database? db;

  DBFunctions._privateConstructor();

  static final DBFunctions instance = DBFunctions._privateConstructor();

  // Open database and table
  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "students.db");

    if (db != null) return db!;

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE students(rollno INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, std TEXT, division TEXT, imagePath TEXT)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE students ADD COLUMN phone TEXT");
        }
      },
    );

    return db!;
  }

  // To check for duplicate insertions
  Future<bool> isduplicateEntry(StudentModel studentModel) async {
    final database = await initDb();

    final result = await database.query(
      'students',
      where:
          'name = ? AND age = ? AND std = ? AND division = ?',
      whereArgs: [
        studentModel.name,
        studentModel.age,
        studentModel.std,
        studentModel.division,
      ],
    );

    //print(result.isNotEmpty);

    return result.isNotEmpty;
  }

  // Insert student details
  Future<int> insertStudent(StudentModel studentModel) async {
    final database = await initDb();
    bool exists = await isduplicateEntry(studentModel);

    if (exists) {
      throw Exception("Duplicate_Student");
    }

    return await database.insert('students', studentModel.toMap());
  }

  // Get student details
  Future<List<StudentModel>> getStudents() async {
    final database = await initDb();
    final result = await database.query('students');
    return result.map((e) => StudentModel.fromMap(e)).toList();
  }

  // Update student data
  Future<int> updateStudent(StudentModel studentModel) async {
    final database = await initDb();
    return await database.update(
      'students',
      studentModel.toMap(),
      where: 'rollno = ?',
      whereArgs: [studentModel.rollno],
    );
  }

  // Delete student data
  Future<int> deleteStudent(int rollno) async {
    final database = await initDb();
    return await database.delete(
      'students',
      where: 'rollno = ?',
      whereArgs: [rollno],
    );
  }
}
