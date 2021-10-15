import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seaoil_technical_exam/models/station_response/area_enum.dart';
import 'package:seaoil_technical_exam/models/station_response/data.dart';
import 'package:seaoil_technical_exam/models/station_response/station_model.dart';
import 'package:seaoil_technical_exam/provider/user_session.dart';
import 'package:seaoil_technical_exam/services/station_service.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  const PanelWidget({Key key, this.controller}) : super(key: key);

  @override
  _PanelWidgetState createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  StationService stationService;
  Future<StationResponseModel> stationResponseModel;
  int selectedValue = -1;

  @override
  void initState() {
    stationService = StationService(context);
    stationResponseModel = getAllStations();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserSession>(
      builder: (context, session, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: session.selectedStation != null && !session.isSearching ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      session.selectedStation = null;
                      setState(() {
                        selectedValue = 0;
                      });
                    },
                    child: const Text("Back to list", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ),
                  Expanded(child: Container(),),
                  TextButton(
                    onPressed: () {
                      print("Done button tap!");
                    },
                    child: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),),
                  ),
                ],
              ),
              const SizedBox(height: 25,),
              Text(session.selectedStation.name, style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold,
              ), textAlign: TextAlign.left,),
              Text(session.selectedStation.address),
              Text("${session.selectedStation.city}, ${areaValues.reverse[session.selectedStation.area]}"),
              const SizedBox(height: 50,),
              Row(
                children: [
                  _bottomBadge(Icons.directions_car, "${session.selectedStation.kmDistanceFromUserDevice.toString()} km away"),
                  const SizedBox(width: 15,),
                  _bottomBadge(Icons.access_time_outlined, "Open 24 hours")
                ],
              ),
            ],
          ) :
          Column(
            children: [
              if(!session.isSearching)
                Row(
                  children: [
                    const Text("Nearby Stations", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    Expanded(child: Container(),),
                    const TextButton(
                      onPressed: null,
                      child: Text("Done", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.grey),),
                    ),
                  ],
                ),
              const SizedBox(height: 30,),
              Expanded(
                child: SingleChildScrollView(
                  controller: widget.controller,
                  child: FutureBuilder<StationResponseModel>(
                    future: stationResponseModel,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        List<StationData> _listData = [];
                        _listData = stationService.sortListByDistanceFromUser(snapshot.data.data);
                        if(session.isSearching && session.searchQuery.isNotEmpty) {
                          _listData = searchStationList(_listData, session.searchQuery);
                        }
                        return Column(
                          children: _listData.map((station) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedValue = station.id;
                                  session.selectedStation = station;
                                  session.updateMapCameraPosition(double.parse(station.lat),
                                      double.parse(station.lng));
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(station.name,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                          ),
                                          const SizedBox(height: 7,),
                                          Text("${station.kmDistanceFromUserDevice.toString()} km away from you")
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container(),),
                                    Radio(
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = station.id;
                                          session.selectedStation = station;
                                          session.updateMapCameraPosition(double.parse(station.lat),
                                              double.parse(station.lng));
                                        });
                                      },
                                      value: station.id,
                                      groupValue: selectedValue,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else if(snapshot.hasError) {
                        return Container(
                          alignment: Alignment.center,
                          child: const Text("Something Went Wrong!"),
                        );
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      }
                    },
                  ),

                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<StationResponseModel> getAllStations() async {
    StationResponseModel _responseModel;
    await stationService.getAllStations().then((value){
      _responseModel = value;
      print(value.data.length);
    });

    return _responseModel;
  }

  Widget _bottomBadge(IconData icon, String desc){
    return Row(
      children: [
        Icon(icon, color: Colors.blue,),
        const SizedBox(width: 10,),
        Text(desc)
      ],
    );
  }

  List<StationData> searchStationList(List<StationData> list, String searchQuery) {
    List<StationData> _toReturnList = [];
    for (var element in list) {
      if(element.name.toLowerCase().contains(searchQuery)) {
        if(!_toReturnList.contains(element)) {
          _toReturnList.add(element);
        }
      }
    }

    return _toReturnList;
  }
}
