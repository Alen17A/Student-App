import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_app/core/utils/show_dialog.dart';
import 'package:student_app/model/student_model.dart';
import 'package:student_app/state/provider/student_provider.dart';

class EditStudent extends StatefulWidget {
  final StudentModel student;
  const EditStudent({super.key, required this.student});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController stdController;
  late TextEditingController divisionController;
  String? imagePath;
  File? image;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    ageController = TextEditingController(text: widget.student.age.toString());
    stdController = TextEditingController(text: widget.student.std);
    divisionController = TextEditingController(text: widget.student.division);
    imagePath = widget.student.imagePath;
  }

  Future<void> pickImage() async {
    final imagePicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imagePicked != null) {
      setState(() {
        image = File(imagePicked.path);
        imagePath = imagePicked.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 235, 240, 235),
      appBar: AppBar(
        title: Text("EDIT STUDENT"),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(height: 40),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => pickImage(),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: image != null
                          ? FileImage(image!)
                          : FileImage(File(imagePath ?? "")),
                      child: imagePath == null
                          ? Icon(Icons.add_a_photo, size: 30)
                          : null,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Tap on the photo to upload new photo",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter your name" : null,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Age",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? "Please enter your age" : null,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Class",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: stdController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter your class" : null,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Division",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: divisionController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter your division" : null,
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
                    try {
                      bool confirm = await showConfirmationDialog(
                        context,
                        "Do you want to save these details?",
                      );

                      if (!confirm) return;

                      if (formKey.currentState!.validate()) {
                        final student = StudentModel(
                          rollno: widget.student.rollno,
                          name: nameController.text,
                          age: int.parse(ageController.text),
                          std: stdController.text,
                          division: divisionController.text,
                          imagePath: imagePath ?? widget.student.imagePath,
                        );

                        context.read<StudentProvider>().updateStudents(student);
                        Navigator.pop(context);
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Student updated successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Failed to update student. Try Again"),
                          backgroundColor: Colors.red,
                        ),
                      );
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
                    "SAVE DETAILS",
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
