import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seaoil_technical_exam/provider/user_session.dart';
import 'package:seaoil_technical_exam/screens/login/login_screen.dart';

class ReusableDialogBoxes {
  static Future<void> showUserNotAllowedDeviceLocationDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text("Prompt", style: Theme.of(context).textTheme.headline6,),
                ),
                const Divider(),
                Container(
                  alignment: Alignment.center,
                  child: const Text("Login successful!\n"
                      "But this is a location finder app, you need to allow your device location to use it.\n"
                      "Try again later.",
                    textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
    );
  }

  static Future<void> showAccessTokenExpiredDialogBox(BuildContext context) {
    UserSession session = Provider.of<UserSession>(context, listen: false);
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text("Warning!", style: Theme.of(context).textTheme.headline6,),
                ),
                const Divider(),
                Container(
                  alignment: Alignment.center,
                  child: const Text("Session Expired!\nYou will be logout.",
                    textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
                    => const LoginScreen())).then((value) => session.cleanSession());
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
    );
  }
}