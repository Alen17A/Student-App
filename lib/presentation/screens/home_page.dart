import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/presentation/widgets/search_bar_widget.dart';
import 'package:student_app/presentation/widgets/student_card.dart';
import 'package:student_app/state/getx/student_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isList = true;
  final studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Edumate",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          actions: [
            // IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/me_bw.jpg"),
            ),
          ],
          actionsPadding: EdgeInsets.all(10),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SearchBarWidget(),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isList = !isList;
                      });
                    },
                    icon: isList
                        ? Icon(Icons.view_list)
                        : Icon(Icons.grid_view),
                  ),
                ),
                SizedBox(height: 10),
                Obx(() {
                  final students = studentController.filteredStudents;
                  if (students.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "No Students added yet. Press the '+' below to add new students",
                      ),
                    );
                  }
                  return isList
                      ? Expanded(
                          child: ListView.separated(
                            itemCount: students.length,
                            itemBuilder: (context, index) => StudentCard(
                              isList: isList,
                              student: students[index],
                            ),
                            separatorBuilder: (context, index) => Divider(
                              indent: 15,
                              endIndent: 15,
                              color: const Color.fromARGB(255, 208, 207, 207),
                            ),
                          ),
                        )
                      : Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                            itemBuilder: (context, index) => StudentCard(
                              isList: isList,
                              student: students[index],
                            ),
                            itemCount: students.length,
                          ),
                        );
                }),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            onPressed: () => Get.toNamed('/add'),
            icon: Icon(Icons.add, size: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
