import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/core/utils/confirmations.dart';
import 'package:student_app/model/student_model.dart';
import 'package:student_app/state/getx/student_controller.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final classController = TextEditingController();
  final divisionController = TextEditingController();

  File? image;
  String? imagePath;

  Future<void> pickImage() async {
    final imagePicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imagePicked != null) {
      setState(() {
        imagePath = imagePicked.path; //To get the image path
        image = File(imagePicked.path); //To get the image file
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD NEW STUDENT"),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(height: 40),
              GestureDetector(
                onTap: () => pickImage(),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: image != null ? FileImage(image!) : null,
                  child: image == null
                      ? Icon(Icons.add_a_photo, size: 30)
                      : null,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Tap on the photo to upload new photo",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter your name" : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(
                        labelText: "Age",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter your age" : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: classController,
                      decoration: InputDecoration(
                        labelText: "Class",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter your class" : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: divisionController,
                      decoration: InputDecoration(
                        labelText: "Division",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty
                          ? "Please enter your class division"
                          : null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () async {
                    bool confirm = await Confirmations.showConfirmationDialog(
                      "Add New Student?",
                    );

                    if (!confirm) return;

                    if (formKey.currentState!.validate()) {
                      final newStudent = StudentModel(
                        name: nameController.text.trim(),
                        age: int.parse(ageController.text.trim()),
                        std: classController.text.trim(),
                        division: divisionController.text.trim(),
                        imagePath: imagePath ?? '',
                      );

                      try {
                        await Get.find<StudentController>().addStudents(
                          newStudent,
                        );
                        Get.back();
                        Confirmations.snackBarSuccess(
                          "Success",
                          "Student Added Successfully",
                        );
                        // Get.snackbar(
                        //   "",
                        //   "Student Added Successfully",
                        //   titleText: Text(
                        //     "Success",
                        //     style: TextStyle(fontWeight: FontWeight.bold),
                        //   ),
                        //   backgroundColor: Colors.white,
                        //   icon: Icon(Icons.check_circle, color: Colors.green),
                        //   borderRadius: 10,
                        //   borderWidth: 3,
                        //   borderColor: Colors.green,
                        // );
                      } catch (e) {
                        if (e.toString().contains("Duplicate_Student")) {
                          Get.rawSnackbar(
                            message: "Student already exists...",
                            backgroundColor: Colors.blue,
                            animationDuration: Duration(seconds: 3),
                          );
                        } else {
                          Confirmations.snackBarFailure("Failed", "Failed to add student");
                        }
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    "ADD STUDENT",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
