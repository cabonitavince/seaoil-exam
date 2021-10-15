import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:seaoil_technical_exam/models/user_model.dart';
import 'package:seaoil_technical_exam/provider/user_session.dart';
import 'package:seaoil_technical_exam/screens/landing/landing_screen.dart';
import 'package:seaoil_technical_exam/services/login_service.dart';
import 'package:seaoil_technical_exam/utilities/app_themes.dart';
import 'package:seaoil_technical_exam/widgets/reusable_dialog_boxes.dart';
import 'package:seaoil_technical_exam/widgets/reusable_snackbar.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _logger = Logger(printer: PrefixPrinter(PrettyPrinter(colors: true)));

  String mobileNumber = "";
  String password = "";
  bool isObscureText = true;
  final LoginService _loginService = LoginService();
  UserModel userModel = UserModel();
  bool isSubmitTap = false;
  bool isAllowed = false;

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
          SizedBox(
            width: isSubmitTap ? 40 : double.infinity,
            child: isSubmitTap ? const CircularProgressIndicator() : ElevatedButton(
              onPressed: () async {
                setState(()=>isSubmitTap = true);
                if(mobileNumber.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(ReusableSnackBar.snackBarNotifier
                    ("Please enter your mobile number and password", Colors.red, 2, false));
                } else {
                  userModel.mobile = mobileNumber;
                  userModel.password = password;
                  await _loginService.loginUser(userModel).then((value) async {
                    UserSession session = Provider.of<UserSession>(context, listen: false);
                    session.loginResponseModel = value;
                    session.userPosition = await _determinePosition();
                    if(session.isUserAllowedLocation) {
                      await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LandingScreen()));
                    } else {
                      await ReusableDialogBoxes.showUserNotAllowedDeviceLocationDialogBox(context);
                    }
                  }).catchError((message){
                    if(message is Exception) {
                      ScaffoldMessenger.of(context).showSnackBar(ReusableSnackBar.snackBarNotifier
                        ("Something Went Wrong! Try again later.", Colors.red, 2, false));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(ReusableSnackBar.snackBarNotifier
                        (message, Colors.red, 2, false));
                    }
                  });
                }
                setState(()=>isSubmitTap = false);
              },
              child: const Text("Submit"),
            ),
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

  Future<Position> _determinePosition() async {
    UserSession session = Provider.of<UserSession>(context, listen: false);
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled) {
      _logger.i('User service is enabled.');
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.deniedForever &&
            permission != LocationPermission.denied) {
          position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best);
          session.isUserAllowedLocation = true;
        } else {
          _logger.i("User denied device location");
        }
      } else if (permission == LocationPermission.deniedForever) {
        _logger.i("User location is denied forever.");
      } else {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        session.isUserAllowedLocation = true;
      }
    } else {
      _logger.i("User service is disabled.");
    }

    return position;
  }
}
