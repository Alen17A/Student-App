import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:student_app/db/functions.dart';
import 'package:student_app/model/student_model.dart';

class StudentController extends GetxController {
  var students = <StudentModel>[].obs;
  var filteredStudents = <StudentModel>[].obs;

  Future<void> loadStudents() async {
    var list = await DBFunctions.instance.getStudents();
    students.assignAll(list);
    filteredStudents.assignAll(students);
  }

  Future<void> addStudents(StudentModel studentModel) async {
    int id = await DBFunctions.instance.insertStudent(studentModel);
    studentModel.rollno = id;
    students.add(studentModel);
    loadStudents();
  }

  Future<void> deleteStudents(int id) async {
    await DBFunctions.instance.deleteStudent(id);
    students.removeWhere((student) => student.rollno == id);
    loadStudents();
  }

  Future<void> updateStudents(StudentModel studentModel) async {
    await DBFunctions.instance.updateStudent(studentModel);
    int index = students.indexWhere(
      (student) => student.rollno == studentModel.rollno,
    );

    if (index != -1) {
      students[index] = studentModel;
      loadStudents();
    }
  }

  void searchStudents(String query) {
    final queryTrimmed = query.toLowerCase().trim();
    if (queryTrimmed.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      // filteredStudents = students.where((student) {
      //   final name = student.name.toLowerCase().trim();

      //   return name.startsWith(queryTrimmed);
      // }).toList();

      filteredStudents.assignAll(students
          .where(
            (student) =>
                student.name.toLowerCase().trim().startsWith(queryTrimmed),
          )
          .toList());
      
    }
  }
}
