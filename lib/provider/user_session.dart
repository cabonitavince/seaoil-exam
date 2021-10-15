import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seaoil_technical_exam/models/login_response/login_response_model.dart';
import 'package:seaoil_technical_exam/models/station_response/data.dart';

class UserSession with ChangeNotifier {
  LoginResponseModel _loginResponseModel;
  Position _userPosition;
  bool _isUserAllowedLocation;
  CameraPosition _cameraPosition;
  final Completer<GoogleMapController> _controller = Completer();
  bool _isSearching;
  StationData _selectedStation;
  String _searchQuery;


  String get searchQuery => _searchQuery ?? "";

  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  StationData get selectedStation => _selectedStation;

  set selectedStation(StationData value) {
    _selectedStation = value;
    notifyListeners();
  }

  bool get isSearching => _isSearching ?? false;

  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  LoginResponseModel get loginResponseModel => _loginResponseModel;

  set loginResponseModel(LoginResponseModel value) {
    _loginResponseModel = value;
    notifyListeners();
  }

  Position get userPosition => _userPosition;

  set userPosition(Position value) {
    _userPosition = value;
    notifyListeners();
  }

  bool get isUserAllowedLocation => _isUserAllowedLocation ?? false;

  set isUserAllowedLocation(bool value) {
    _isUserAllowedLocation = value;
    notifyListeners();
  }

  CameraPosition get cameraPosition => _cameraPosition;

  set cameraPosition(CameraPosition value) {
    _cameraPosition = value;
    notifyListeners();
  }


  Completer<GoogleMapController> get controller => _controller;

  Future<void> updateMapCameraPosition(double lat, double lang) async {
    CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(lat, lang),
      zoom: 19.151926040649414,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    notifyListeners();
  }

  void cleanSession() {
    _loginResponseModel = null;
    _cameraPosition = null;
    _isSearching = false;
    _selectedStation = null;
    _searchQuery = "";
    notifyListeners();
  }
}