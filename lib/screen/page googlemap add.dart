import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syriaonline/constant/constent.dart';

const kGoogleApiKey = "AIzaSyDELVyIyOWK-s4frDfUmU81fBESRMsEkRE";

class GooglemapsAdd extends StatefulWidget {
  @override
  _GooglemapsAddState createState() => _GooglemapsAddState();
}

class _GooglemapsAddState extends State<GooglemapsAdd> {
  GoogleMapController mapController;
  BitmapDescriptor custommarker;
  getCustommarker() async {
    custommarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'img/icons/marker.png');
  }

  @override
  void initState() {
    super.initState();
    //جلب جميع الماركر عند فتح الصفحة
    getCustommarker();
  }
  //----------------------------map type----------------------------------------

  var maptype = MapType.normal;
  //-----------------------------for marker-------------------------------------
  Marker marker = Marker(markerId: MarkerId("0"));
  int id = Random().nextInt(100);
  LatLng fposition;
  List<Marker> markers = [];
  addmarker(cordinate) {
    setState(() {
      marker = Marker(
          markerId: MarkerId(id.toString()),
          position: cordinate,
          icon: custommarker);
    });
  }

//---------------------for current location-------------------------------------
  //اخذ موقع الجهاز الحالي
  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  void currentlocatorPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngposition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngposition, zoom: 18);
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
          mapType: maptype,

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
          //--------------------------marker------------------------------------
          //وضع الماركر على الخريطة
          markers: marker != null ? <Marker>[marker].toSet() : null,
          onTap: (cordinate) async {
            mapController.animateCamera(CameraUpdate.newLatLng(cordinate));
            addmarker(cordinate);

            print(cordinate);
          },
          initialCameraPosition: _cameraPosition,
        ),
        //---------------------------change map type----------------------------

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
        //---------------------------save location------------------------------
        Positioned(
          bottom: 20,
          left: 10,
          child: Container(
            width: 100,
            height: 40,
            child: ElevatedButton(
              child: Text("Save"),
              onPressed: () {
                fposition = marker.position;
                if (fposition != null) {
                  Navigator.pop(context, fposition);
                } else {
                  print("postion is null");
                }
              },
              style: ElevatedButton.styleFrom(
                primary: kButtonSaveLocationColor,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
