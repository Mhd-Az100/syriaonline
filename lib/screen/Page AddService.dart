import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:syriaonline/constant/constent.dart';
import 'package:syriaonline/constant/drawer.dart';
import 'package:syriaonline/screen/page%20googlemap%20add.dart';
import 'package:syriaonline/service/postApi.dart';
import 'package:syriaonline/utils/allUrl.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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

  double x = 123.5;
  double y = 123.5;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String defultSelect = 'Other';
  var items = ['Other', 'Restaurants', 'Clothes', 'Markets', 'Pharmacies'];

  addseRvice(context, Map map) async {
    bool result = await postdata(services, map);
    print(result);
    print(map);
  }

  Future uploadimg() async {
    if (_file == null) return;
    String base64 = base64Encode(_file.readAsBytesSync());
    String imgname = _file.path.split('/').last;
    print(base64);
    print(imgname);
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text(
          'Add Service',
          style: kTitleAppbarStyle,
        ),
      ),
      drawer: MyDrawer(),
      body: Container(
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
                      height: 50,
                      decoration: BoxDecoration(
                        color: kBackTextColor,
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
              Padding(
                padding:
                    const EdgeInsets.only(left: 52.0, right: 52.0, top: 20),
                child: DropdownButton<String>(
                  value: defultSelect,
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Color((0xEA349CAF)),
                    ),
                  ),
                  iconSize: 40,
                  elevation: 10,
                  style: kTextBody,
                  underline: Container(height: 3, color: kBackTextColor),
                  onChanged: (String newValue) {
                    setState(() {
                      defultSelect = newValue;
                    });
                  },
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 59,
                        padding: EdgeInsets.only(
                            top: 8, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name of Service',
                            hintStyle: TextStyle(
                              color: Color(0xE8349CAF),
                            ),
                          ),
                          controller: nameController,
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          //onSaved: ,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 59,
                        padding: EdgeInsets.only(
                            top: 8, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '+963',
                            prefixText: '+963',
                            hintStyle: TextStyle(color: Color(0xE8349CAF)),
                            icon: Icon(
                              Icons.phone,
                              color: Color((0xFF349DAF)),
                            ),
                          ),
                          controller: numberController,
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: Center(
                          child: TextFormField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Descreption',
                              hintStyle: TextStyle(
                                color: Color(0xE8349CAF),
                              ),
                            ),
                            controller: descriptionController,
                            validator: (String value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
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
                  style: kTextinfo,
                ),
              ),
              //-------------------add photo------------------------------------
              GestureDetector(
                onTap: () => getImage(ImageSource.gallery),
                child: Container(
                  margin: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.all(5.0),
                  child: _file == null
                      ? Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 100,
                          color: Color(0xFF349DAF),
                        )
                      : Image.file(_file),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kButtonColor)),
                    onPressed: () async {
                      Map addservices = {
                        'account_id': '2',
                        'service_name': nameController.text,
                        'service_phone_number': numberController.text,
                        'service_description': descriptionController.text,
                        'service_catogary_id': '2',
                        'x': "$x",
                        'y': "$y",
                        'manger_accept': '1',
                        "picture": 'picture',
                      };
                      setState(() {
                        addseRvice(context, addservices);
                        print("Add");
                        print(addseRvice);
                        uploadimg();
                      });
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        // Process data.
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching_outlined),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GooglemapsAdd()),
          );
        },
      ),
    );
  }
}
