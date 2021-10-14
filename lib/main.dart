import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seaoil_technical_exam/app/main_app.dart';
import 'package:seaoil_technical_exam/provider/provider_factory.dart';

void main() {
  runApp(MultiProvider(
    providers: ProviderFactory().createProviders(),
    child: const MainApp(),
  ));
}