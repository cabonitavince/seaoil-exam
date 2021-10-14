import 'package:flutter/material.dart';

class AppThemes {
  static BoxShadow shadowRegular() {
    return BoxShadow(
      color: Colors.black.withOpacity(0.1),
      spreadRadius: 0,
      blurRadius: 20,
      offset: const Offset(3, 8), // changes position of shadow
    );
  }
}