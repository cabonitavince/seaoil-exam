import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:seaoil_technical_exam/provider/user_session.dart';
import 'package:seaoil_technical_exam/screens/landing/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class LandingScreen extends StatefulWidget {
  const LandingScreen({Key key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  CameraPosition _initialCameraPosition;

  @override
  void initState() {
    setInitialCameraPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserSession>(
      builder: (context, session, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: session.isSearching ? const Size.fromHeight(160.0) : const Size.fromHeight(100.0),
            child: Container(
              color: Colors.deepPurple,
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width*0.37,),
                        const Text("Search Station", style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold, fontSize: 17),),
                        Expanded(child: Container()),
                        IconButton(
                          onPressed: () {
                            session.isSearching = !session.isSearching;
                            session.searchQuery = "";
                          },
                          icon: Icon(session.isSearching ? Icons.close : Icons.search, color: Colors.white,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const Text("Which PriceLOCQ station will you likely to visit?", style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold, fontSize: 14),),
                    if(session.isSearching)
                      Container(
                        margin: const EdgeInsets.only(left: 50, right: 50, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.grey,),
                            border: OutlineInputBorder(),
                            hintText: "Search"
                          ),
                          onChanged: (value) {
                            session.searchQuery = value;
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              SlidingUpPanel(
                // parallaxEnabled: true,
                // parallaxOffset: 0.5,
                maxHeight: session.isSearching ? MediaQuery.of(context).size.height : 300,
                minHeight: session.isSearching ? MediaQuery.of(context).size.height : 300,
                borderRadius: session.isSearching ? null : const BorderRadius.vertical(top: Radius.circular(25)),
                panelBuilder: (controller) => PanelWidget(
                  controller: controller,
                ),
                body: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    session.controller.complete(controller);
                  },
                ),
              ),
              if(!session.isSearching)
                Positioned(
                  right: 20,
                  bottom: 320,
                  child: fab(),
                )
            ],
          ),
        );
      },
    );
  }

  void setInitialCameraPosition() {
    UserSession session = Provider.of<UserSession>(context, listen: false);
    _initialCameraPosition = CameraPosition(
      target: LatLng(session.userPosition.latitude, session.userPosition.longitude),
      zoom: 19.151926040649414,
    );
  }

  Widget fab() {
    UserSession session = Provider.of<UserSession>(context, listen: false);
    return FloatingActionButton(
      backgroundColor: Colors.white,
      child: const Icon(Icons.gps_fixed, color: Colors.black,),
      onPressed: () {
        session.updateMapCameraPosition(session.userPosition.latitude,
            session.userPosition.longitude);
        session.selectedStation == null;
      },
    );
  }
}
