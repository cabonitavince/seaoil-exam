import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:seaoil_technical_exam/models/login_response/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:seaoil_technical_exam/models/user_model.dart';

class LoginService {
  final _logger = Logger(printer: PrefixPrinter(PrettyPrinter(colors: true)));
  final String _loginApiUrl = "https://stable-api.pricelocq.com/mobile/v2/sessions";

  Future<LoginResponseModel> loginUser(UserModel userModel) async {
    LoginResponseModel _loginResponse;
    try {
      final response = await http.post(Uri.parse(_loginApiUrl), body: jsonEncode(userModel));

      if(response.statusCode == 200) {
        final decodedBodyResponse = json.decode(response.body);
        if(decodedBodyResponse["status"] == "success") {
          _loginResponse = LoginResponseModel.fromJson(jsonDecode(response.body));
        } else {
          throw decodedBodyResponse["data"]["message"];
        }
      } else {
        throw "Bad Request! Status Code: ${response.statusCode}";
      }

    } on Exception catch (e) {
      _logger.e(e.toString());
      rethrow;
    }

    return _loginResponse;
  }
}