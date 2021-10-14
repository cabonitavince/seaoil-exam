import 'package:flutter/material.dart';
import 'package:seaoil_technical_exam/utilities/app_themes.dart';
import 'package:seaoil_technical_exam/widgets/reusable_snackbar.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String mobileNumber = "";
  String password = "";
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          AppThemes.shadowRegular(),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                AppThemes.shadowRegular(),
              ],
            ),
            child: TextFormField(
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  mobileNumber = value;
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.contact_phone_rounded),
                border: InputBorder.none,
                hintText: "Mobile Number",
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {
                      setState(() {
                        password= value;
                      });
                    },
                    obscureText: isObscureText,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: TextButton(
                    child: Text(
                      isObscureText ? "Show" : "Hide",
                      style: const TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      _toggleShowHidePassword();
                    },
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                AppThemes.shadowRegular()
              ],
            ),
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              if(mobileNumber.isEmpty && password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(ReusableSnackBar.snackBarNotifier
                  ("Please enter your username and password", Colors.red, 2, false));
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  void _toggleShowHidePassword() {
    setState(() {
      isObscureText = !isObscureText;
    });
  }
}
