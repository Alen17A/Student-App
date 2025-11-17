import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:student_app/core/utils/show_dialog.dart';
import 'package:student_app/model/student_model.dart';
import 'package:student_app/presentation/screens/edit_student.dart';
import 'package:student_app/state/getx/student_controller.dart';

class DetailsPage extends StatelessWidget {
  final StudentModel studentModel;
  const DetailsPage({super.key, required this.studentModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 235, 240, 235),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("STUDENT DETAILS"),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            CircleAvatar(
              backgroundImage: FileImage(File(studentModel.imagePath ?? "")),
              radius: 80,
            ),
            SizedBox(height: 10),
            Text(
              studentModel.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Roll No:",
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 87, 85, 85),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  studentModel.rollno.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 87, 85, 85),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 5,
              color: const Color.fromARGB(255, 241, 240, 240),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Age",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 106, 106, 106),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        studentModel.age.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Class",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 106, 106, 106),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        studentModel.std,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Division",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 106, 106, 106),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        studentModel.division,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: TextButton.icon(
                      onPressed: () {
                        Get.to(() => EditStudent(student: studentModel));
                      },
                      label: Text(
                        "EDIT DETAILS",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Icon(Icons.edit, color: Colors.white),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: TextButton.icon(
                      onPressed: () async {
                        bool
                        confirm = await Confirmations.showConfirmationDialog(
                          "Are you sure you want to remove ${studentModel.name}?",
                        );

                        if (!confirm) return;

                        try {
                          Get.find<StudentController>().deleteStudents(
                            studentModel.rollno!,
                          );
                          Get.back();
                          Confirmations.snackBarSuccess(
                            "Success",
                            "Student Removed Successfully",
                          );
                        } catch (e) {
                          Confirmations.snackBarFailure("Failed", "Failed to remove student");
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      label: Text(
                        "DELETE STUDENT",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
