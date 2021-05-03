import 'package:flutter/material.dart';
import '../constant/constent.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../constant/drawer.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  //img from device///////////

  File _image;
  final picker = ImagePicker();

  Future getImage(x) async {
    final pickedFile = await picker.getImage(source: x);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String defultSelect = 'Other';
  var items = ['Other', 'Restaurants', 'Clothes', 'Markets', 'Pharmacies'];
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
              //dropdown&&lebel///////////
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  value: defultSelect,
                  icon: const Icon(Icons.arrow_circle_down_rounded),
                  iconSize: 24,
                  elevation: 16,
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
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: kBackTextColor,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(65)),
                    ),
                    child: Center(
                      child: Text(
                        '   Enter your service type',
                        style: kTextBody,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),

            ///form/////////////////////////
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Name of Service',
                      ),
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        hintText: '+963',
                        prefixText: '+963',
                        icon: Icon(
                          Icons.phone,
                          color: Color(0xFF0457F1),
                        ),
                      ),
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: 'Descreption',
                      ),
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kButtonColor)),
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            // Process data.
                          }
                        },
                        child: Text('Add Service'),
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
            //add photo////////////////////////////
            GestureDetector(
              onTap: () => getImage(ImageSource.gallery),
              child: Container(
                margin: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
                padding: EdgeInsets.all(5.0),
                child: _image == null
                    ? Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 100,
                      )
                    : Image.file(_image),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
