import 'package:flutter/material.dart';
import 'package:seaoil_technical_exam/screens/login/login_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SeaOil Exam",
      home: LoginScreen(),
    );
  }
}
