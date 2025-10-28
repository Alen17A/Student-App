import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final bool isList;
  final int index;
  const StudentCard({super.key, required this.isList, required this.index});

  @override
  Widget build(BuildContext context) {
    return isList
        ? ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/Logo.jpg"),
              radius: 30,
            ),
            title: Text("Student $index"),
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/Logo.jpg"),
                  radius: 30,
                ),
                SizedBox(height: 5),
                Text("Student $index"),
              ],
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