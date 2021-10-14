import 'package:flutter/material.dart';
import 'package:seaoil_technical_exam/utilities/app_themes.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
        boxShadow: [
          AppThemes.shadowRegular(),
        ],
      ),
      child: Image.asset("lib/assets/images/seaoil_logo.png", fit: BoxFit.contain,),
    );
  }
}
