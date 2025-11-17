import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:student_app/db/functions.dart';
import 'package:student_app/presentation/screens/add_student.dart';
import 'package:student_app/presentation/screens/home_page.dart';
import 'package:student_app/presentation/screens/splash_screen.dart';
import 'package:student_app/state/getx/student_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBFunctions.instance.initDb();
  Get.put(StudentController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App with GetX',
      theme: ThemeData(primarySwatch: Colors.green),
      // home: SplashScreen(),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/add', page: () => const AddStudent()),
      ],
    );
  }
}
