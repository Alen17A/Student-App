import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/db/functions.dart';
import 'package:student_app/presentation/screens/splash_screen.dart';
import 'package:student_app/state/provider/student_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBFunctions.instance.initDb();
  runApp(
    ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App with Provider',
      home: SplashScreen(),
    );
  }
}
