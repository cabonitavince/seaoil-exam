import 'package:flutter/cupertino.dart';
import 'package:seaoil_technical_exam/models/login_response/login_response_model.dart';

class UserSession with ChangeNotifier {
  LoginResponseModel _loginResponseModel;

  LoginResponseModel get loginResponseModel => _loginResponseModel;

  set loginResponseModel(LoginResponseModel value) {
    _loginResponseModel = value;
    notifyListeners();
  }
}