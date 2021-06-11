import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/model/model%20services.dart';
import 'package:syriaonline/provider/providerData.dart';
import 'package:syriaonline/screen/page%20service%20info.dart';
import 'package:syriaonline/service/getAllService.dart';

const kGoogleApiKey = "AIzaSyDELVyIyOWK-s4frDfUmU81fBESRMsEkRE";

class GooglemapsAll extends StatefulWidget {
  @override
  _GooglemapsAllState createState() => _GooglemapsAllState();
}

class _GooglemapsAllState extends State<GooglemapsAll> {
  GoogleMapController mapController;
  ServicesModel service;
  BitmapDescriptor custommarker;

  @override
  void initState() {
    super.initState();
    service = Provider.of<Providerdata>(context, listen: false).service;

    allServiceMarker();
  }

//-------------------------------get all markers------------------------------------
  List<Marker> markers = [];
  List<ServicesModel> allserv;
  allServiceMarker() async {
    GetServiceMarker getServiceApi = new GetServiceMarker();
    List<ServicesModel> servLst = await getServiceApi.getmark();
    setState(() {
      allserv = servLst;
    });
    for (ServicesModel item in allserv) {
      markers.add(
        Marker(
          markerId: MarkerId(item.serviceId.toString()),
          position: LatLng(double.parse(item.x), double.parse(item.y)),
          infoWindow: InfoWindow(
              title: "${item.serviceName}",
              snippet: "${item.serviceDescription}",
              onTap: () {
                setService(context: context, val: item);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ServiceInfo(
                            // service: service,
                            )));
              }),
        ),
      );
    }
  }

  //----------------------------map type----------------------------------------

  var maptype = MapType.normal;

//---------------------for current location-------------------------------------
  Position currentPosition;
  var geoLocator = Geolocator();
  CameraPosition cameraPosition;
  double bottomPaddingOfMap = 0;
  void currentlocatorPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngposition = LatLng(position.latitude, position.longitude);
    cameraPosition = CameraPosition(target: latLngposition, zoom: 18);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(33.51396767600139, 36.27581804468471),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
              currentlocatorPosition();
            });
          },
          markers: markers.toSet(),

          initialCameraPosition: _cameraPosition,
          mapType: maptype,

          // onMapCreated: (controller) {
          //   setState(() {
          //     bottomPaddingOfMap = 300;
          //     mapController = controller;
          //   });
          // },
          //------------------------------marker-------------------------------

          // markers: markers.toSet(),
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          // initialCameraPosition: _cameraPosition,
        ),
        Positioned(
          bottom: 10,
          right: 100,
          child: RawMaterialButton(
            onPressed: () {
              setState(() {
                maptype == MapType.normal
                    ? maptype = MapType.hybrid
                    : maptype = MapType.normal;
              });
            },
            padding: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            child: Container(
              height: 70,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: kButtongradientColor,
              ),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                'Map \nType',
                textAlign: TextAlign.center,
                style: kTextButton,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
