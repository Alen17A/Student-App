import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:student_app/model/student_model.dart';
import 'package:student_app/presentation/screens/details_page.dart';

class StudentCard extends StatelessWidget {
  final bool isList;
  final StudentModel student;
  const StudentCard({super.key, required this.isList, required this.student});

  @override
  Widget build(BuildContext context) {
    return isList
        ? ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(File(student.imagePath ?? "")),
              radius: 30,
            ),
            title: Text(
              student.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => Get.to(() => DetailsPage(studentModel: student)),
          )
        : GestureDetector(
            onTap: () => Get.to(() => DetailsPage(studentModel: student)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(File(student.imagePath ?? "")),
                    radius: 30,
                  ),
                  SizedBox(height: 5),
                  Text(
                    student.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  // SizedBox(height: 5),
                  // Text(
                  //   "Roll No: ${rollno.toString()}",
                  //   style: TextStyle(fontSize: 12),
                  // ),
                ],
              ),
            ),
          );
  }
}









// ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.asset(
//                 "assets/images/Logo.jpg",
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),