import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const kGoogleApiKey = "AIzaSyDELVyIyOWK-s4frDfUmU81fBESRMsEkRE";

class Googlemaps extends StatefulWidget {
  @override
  _GooglemapsState createState() => _GooglemapsState();
}

class _GooglemapsState extends State<Googlemaps> {
  GoogleMapController mapController;
  // String sreachAddr; search

  // //for marker ////////////////
  List<Marker> markers = [];
  addmarker(cordinate) {
    int id = Random().nextInt(100);
    setState(() {
      markers = [];
      markers
          .add(Marker(markerId: MarkerId(id.toString()), position: cordinate));
    });
  }

//for current location//////////////
  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  void currentlocatorPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngposition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngposition, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(33.51396767600139, 36.27581804468471),
    zoom: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,

          onMapCreated: (controller) {
            setState(() {
              bottomPaddingOfMap = 300;
              mapController = controller;
            });
            currentlocatorPosition();
          },
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          //marker///////////////////
          markers: markers.toSet(),
          onTap: (cordinate) async {
            mapController.animateCamera(CameraUpdate.newLatLng(cordinate));
            addmarker(cordinate);
          },
          initialCameraPosition: _cameraPosition,
        ),

        // Positioned(
        //     top: 30,
        //     right: 0,
        //     child: RawMaterialButton(
        //       onPressed: () {},
        //       elevation: 1.0,
        //       fillColor: Colors.blue[300],
        //       child: Icon(
        //         Icons.search,
        //         size: 25.0,
        //       ),
        //       padding: EdgeInsets.all(10.0),
        //       shape: CircleBorder(),
        //     )),
      ],
    );
  }
}
