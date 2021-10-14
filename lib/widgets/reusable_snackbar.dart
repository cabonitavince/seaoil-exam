import 'package:flutter/material.dart';

class ReusableSnackBar {
  static snackBarNotifier(String message, Color color, int seconds, bool isLoading) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: seconds),
      content: Row(
        children: <Widget>[
          if(isLoading)
            const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          else
            Icon(
              Icons.info,
              color: color,
            ),
          const SizedBox(
            width: 10,
          ),
          Text(message),
        ],
      ),
    );
  }
}