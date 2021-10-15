import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:seaoil_technical_exam/models/station_response/data.dart';
import 'package:seaoil_technical_exam/models/station_response/station_model.dart';
import 'package:http/http.dart' as http;
import 'package:seaoil_technical_exam/provider/user_session.dart';
import 'package:seaoil_technical_exam/widgets/reusable_dialog_boxes.dart';

class StationService {
  final _logger = Logger(printer: PrefixPrinter(PrettyPrinter(colors: true)));
  final String _getStationsUrl = "https://stable-api.pricelocq.com/mobile/stations?all";
  final BuildContext _context;
  StationService(this._context);

  Future<StationResponseModel> getAllStations() async {
    UserSession session = Provider.of<UserSession>(_context, listen: false);
    StationResponseModel _stationResponseModel;

    try {
      final response = await http.get(Uri.parse(_getStationsUrl), headers: {
        'Authorization': session.loginResponseModel.data.accessToken
      });

      if(response.statusCode == 200) {
        final decodedBodyResponse = json.decode(response.body);
        if(decodedBodyResponse["status"] == "success") {
          _stationResponseModel = StationResponseModel.fromJson(jsonDecode(response.body));
          bool isExpired = _checkIfAccessTokenAlreadyExpired(session.loginResponseModel.data.expiresAt);
          if(isExpired) {
            await ReusableDialogBoxes.showAccessTokenExpiredDialogBox(_context);
          }
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

    return _stationResponseModel;
  }

  List<StationData> sortListByDistanceFromUser(List<StationData> list) {
    UserSession session = Provider.of<UserSession>(_context, listen: false);
    for (var station in list) {
      double distanceInMeters = Geolocator.distanceBetween(session.userPosition.latitude,
          session.userPosition.longitude, double.parse(station.lat), double.parse(station.lng));
      double distanceInKm = double.parse((distanceInMeters / 1000).toStringAsExponential(1));
      station.kmDistanceFromUserDevice = distanceInKm;
    }
    list.sort((station1, station2)=>station1.kmDistanceFromUserDevice.compareTo(station2.kmDistanceFromUserDevice));

    return list;
  }

  bool _checkIfAccessTokenAlreadyExpired(DateTime expDate) {
    return expDate.isBefore(DateTime.now());
  }
}