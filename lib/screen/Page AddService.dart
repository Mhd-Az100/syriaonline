import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/model/model%20category%20.dart';
import 'package:syriaonline/screen/page%20choose.dart';
import 'package:syriaonline/screen/page%20googlemap%20add.dart';
import 'package:syriaonline/service/categoryApi.dart';
import 'package:syriaonline/service/postApi.dart';
import 'package:syriaonline/utils/allUrl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  var nameController = TextEditingController();
  var numberController = TextEditingController();
  var descriptionController = TextEditingController();

  var servName, servDesc, servPhoneNumber;
  var detectLocation = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //--------------------------------dropDownButton------------------------------
  int idcate;
  var select = false;
  CategoryModel defultSelect;
  int selectCatesID = 0;

  List<CategoryModel> categories;

  getdroplst() async {
    GetCategoryApi cat = GetCategoryApi();

    List<CategoryModel> catsRes = await cat.getcateg();
    setState(() {
      categories = catsRes;
    });
  }

  //-------------------------------------get id user----------------------------
  var iduser;

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      iduser = preferences.getString('account_id');
    });
  }

//-----------------------------for location-------------------------------------
  LatLng positioned;

  //--------------------------- coordinates احداثيات---------------------------
  Widget _coordinates() {
    return FloatingActionButton(
      onPressed: () async {
        positioned = await Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new GooglemapsAdd()));
      },
      backgroundColor:
          this.positioned == null ? Colors.red : Colors.lightGreen[700],
      child: Icon(Icons.add_location_alt_outlined),
    );
  }

  //----------------------img from device---------------------------------------

  File _file;
  final picker = ImagePicker();

  Future getImage(x) async {
    final pickedFile = await picker.getImage(source: x);

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

//----------------------------send data-----------------------------------------
  bool result = false;
  addseRvice(context, Map map) async {
    result = await postdata(services, map);

    result
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ChoosePage()))
        : Fluttertoast.showToast(
            backgroundColor: Color(0xB7FF0000),
            msg: 'error Add',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);

    print(result);
    print(map);
  }

  void initState() {
    super.initState();
    getpref();
    getdroplst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  //-------------dropdown&&lebel----------------------------------
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: kchooseColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(65),
                            bottomRight: Radius.circular(65),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Enter your service type',
                            style: kTextBodyApp,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 25,
                ),

                //--------------------------------form----------------------------
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //--------------------name service----------------------
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 59,
                                padding: EdgeInsets.only(
                                    top: 8, left: 16, right: 16, bottom: 4),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
                                    ]),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Name of Service',
                                      hintStyle: kHintStyle),
                                  controller: nameController,
                                  validator: validateName,
                                  onSaved: (val) => servName = val,
                                  //onSaved: ,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: defultSelect,
                                  icon: const Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: kiconColor,
                                  ),
                                  iconSize: 30,
                                  elevation: 10,
                                  style: kTextdropdown,
                                  underline:
                                      Container(height: 3, color: kchooseColor),
                                  items: categories?.map((CategoryModel cates) {
                                        return DropdownMenuItem<CategoryModel>(
                                          value: cates,
                                          child: Text(
                                            cates.servicesCatogaryName
                                                .toString(),
                                          ),
                                        );
                                      })?.toList() ??
                                      [],
                                  hint: Text("SelectType", style: kTextinfo),
                                  onChanged: (newValue) {
                                    setState(() {
                                      this.defultSelect = newValue;
                                      this.selectCatesID =
                                          defultSelect.serviceCatogaryId;
                                      idcate = this.selectCatesID;
                                      print(idcate);
                                      select = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        //--------------------phon service----------------------
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 59,
                          padding: EdgeInsets.only(
                              top: 8, left: 16, right: 16, bottom: 4),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 5)
                              ]),
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefix: Text('+963'),
                              hintStyle: kHintStyle,
                              icon: Icon(
                                Icons.phone,
                                color: kiconColor,
                              ),
                            ),
                            controller: numberController,
                            validator: validateMobile,
                            onSaved: (val) => servPhoneNumber = val,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        //-------------------Descr service----------------------
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          padding: EdgeInsets.only(
                              top: 4, left: 16, right: 16, bottom: 4),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 5)
                              ]),
                          child: Center(
                            child: TextFormField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Descreption',
                                  hintStyle: kHintStyle),
                              controller: descriptionController,
                              validator: validateDescreption,
                              onSaved: (val) => servDesc = val,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'pressed to add your photo',
                    style: kTextBody,
                  ),
                ),

                //-------------------add photo------------------------------------
                GestureDetector(
                  onTap: () => getImage(ImageSource.gallery),
                  child: Container(
                    margin: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width - 250,
                    height: MediaQuery.of(context).size.width - 250,
                    decoration: BoxDecoration(),
                    padding: EdgeInsets.all(5.0),
                    child: _file == null
                        ? Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 75,
                            color: kiconColor,
                          )
                        : Image.file(_file),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kchooseColor)),
                      onPressed: () async {
                        if (select == false) {
                          Fluttertoast.showToast(
                              backgroundColor: Color(0xB7FF0000),
                              msg: 'choose service category',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM);
                        }
                        if (select == false) {
                          Fluttertoast.showToast(
                              backgroundColor: Color(0xB7FF0000),
                              msg: 'choose service category',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM);
                        }
                        if (positioned == null) {
                          Fluttertoast.showToast(
                              backgroundColor: Color(0xB7FF0000),
                              msg: 'Add Location',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM);
                        }
                        if (_formKey.currentState.validate() &&
                            // positioned != null &&
                            select == true) {
                          //-----------upload image -----------

                          if (_file != null) {
                            String base64 =
                                base64Encode(_file.readAsBytesSync());
                            String imgname = _file.path.split('/').last;
                            //--------------with photo ---------------

                            setState(() {
                              Map addservices = {
                                'account_id': iduser.toString(),
                                'service_name': nameController.text,
                                'service_phone_number': numberController.text,
                                'service_description':
                                    descriptionController.text,
                                'service_catogary_id': idcate.toString(),
                                'x': positioned.latitude.toString(),
                                'y': positioned.longitude.toString(),
                                'manger_accept': '1',
                                "imgname": imgname,
                                "base64": base64,
                              };
                              addseRvice(context, addservices);
                              print("Add");
                              print(addseRvice);
                            });
                          } else {
                            //--------------withOut photo ---------------

                            setState(() {
                              Map addservices = {
                                'account_id': iduser.toString(),
                                'service_name': nameController.text,
                                'service_phone_number': numberController.text,
                                'service_description':
                                    descriptionController.text,
                                'service_catogary_id': idcate.toString(),
                                'x': positioned.latitude.toString(),
                                'y': positioned.longitude.toString(),
                                'manger_accept': '1',
                              };
                              addseRvice(context, addservices);
                              print("Add");
                              print(addseRvice);
                            });
                          }
                        } else {
                          Fluttertoast.showToast(
                              backgroundColor: Color(0xB7FF0000),
                              msg: 'error Add',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM);
                        }
                      },
                      child: Text('Add Service'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //-----------------Floating Gps-----------------------------------------
        Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              children: [
                _coordinates(),
              ],
            ))
      ]),
    );
  }

  //------------------------Validation-----------------------------------------
  String validateMobile(String value) {
    if (value.length == 0)
      return 'Please enter PhoneNumber';
    else if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validateName(String value) {
    if (value.length == 0)
      return 'Please enter name of service...';
    else
      return null;
  }

  String validateDescreption(String value) {
    if (value.length == 0)
      return 'Please enter a descreption...';
    else
      return null;
  }
}
