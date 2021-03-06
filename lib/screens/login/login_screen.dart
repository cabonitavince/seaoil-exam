import 'package:flutter/material.dart';
import 'package:seaoil_technical_exam/screens/login/login_form.dart';
import 'package:seaoil_technical_exam/screens/login/logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: const Logo()
          ),
          const SizedBox(height: 20,),
          Text("SeaOil Station\nFinder",
            style: Theme.of(context).textTheme.headline5.copyWith(
              letterSpacing: 6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15,),
          const LoginForm(),
        ],
      ),
    );
  }
}
