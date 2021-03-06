import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'page%20login.dart';
import 'package:syriaonline/utils/allUrl.dart';
import '../constant/constent.dart';
import '../widgets/signup/signuprawMaterialButton.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class SignUP extends StatefulWidget {
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController accounttypeidController = TextEditingController();
  bool loading = false;
  var firstname, lastname, email, phone, pass;

  final signupformKey = new GlobalKey<FormState>();
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
  //-------------------------register sign up ----------------------------------

  void register() async {
    if (signupformKey.currentState.validate()) {
      var url = Uri.parse(account);
      setState(() {
        loading = true;
      });
      if (_file != null) {
        String base64 = base64Encode(_file.readAsBytesSync());
        String imgname = _file.path.split('/').last;
        //--------------with photo ---------------
        var data = {
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "e_mail": emailController.text,
          "user_phone_number": phoneController.text,
          "passowrd": passwordController.text,
          'account_type_id': '2',
          "imgname": imgname,
          "base64": base64,
        };
        print(data);
        http.Response res = await http.post(url, body: data);

        if (res.statusCode == 201) {
          var resbody = jsonDecode(res.body);
          print('message ${res.body}');

          setState(() {
            loading = false;
          });

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else {
          print('statuscode=${res.statusCode}');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SignUP(),
            ),
          );
          Fluttertoast.showToast(
              timeInSecForIosWeb: 2,
              backgroundColor: Color(0xB7FF0000),
              msg: 'This account already exists',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        }
      }
      //--------------without photo ---------------
      else {
        var data = {
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "e_mail": emailController.text,
          "user_phone_number": phoneController.text,
          "passowrd": passwordController.text,
          'account_type_id': '2',
        };
        print(data);

        http.Response res = await http.post(url, body: data);

        if (res.statusCode == 201) {
          var resbody = jsonDecode(res.body);
          print('message ${res.body}');

          setState(() {
            loading = false;
          });

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else {
          print('statuscode=${res.statusCode}');

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SignUP(),
            ),
          );
          Fluttertoast.showToast(
              timeInSecForIosWeb: 2,
              backgroundColor: Color(0xB7FF0000),
              msg: 'This account already exists',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        }
      }
    }
  }

  //------------------shared preferences----------------------------------------

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: (loading == false)
          ? Container(
              color: kchooseColor,
              width: size.width,
              height: size.height,
              child: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(200),
                        bottomRight: Radius.circular(200)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Form(
                          key: signupformKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => getImage(ImageSource.gallery),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    width: 120,
                                    height: 120,
                                    margin: EdgeInsets.only(
                                      top: 10.0,
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    child: _file == null
                                        ? SvgPicture.asset(
                                            "img/icons/avatar.svg",
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: FileImage(
                                                    _file,
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 35),
                                  child: Text('Add Photo'),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: (size.width / 2) - 10,
                                      height: 50,
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5)
                                          ]),
                                      child: TextFormField(
                                        controller: firstNameController,
                                        keyboardType: TextInputType.text,
                                        validator: (val) => val.length == 0
                                            ? 'Please Enter Your First Name'
                                            : null,
                                        onSaved: (val) => firstname = val,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Icon(
                                            Icons.person_pin,
                                            color: klabelTextColor
                                                .withOpacity(0.5),
                                          ),
                                          hintText: 'First Name',
                                          hintStyle: TextStyle(
                                            color: klabelTextColor
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: (size.width / 2) - 10,
                                      height: 50,
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5)
                                          ]),
                                      child: TextFormField(
                                        controller: lastNameController,
                                        keyboardType: TextInputType.text,
                                        validator: (val) => val.length == 0
                                            ? 'Please Enter Your Last Name'
                                            : null,
                                        onSaved: (val) => lastname = val,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Icon(
                                            Icons.person_pin,
                                            color: klabelTextColor
                                                .withOpacity(0.5),
                                          ),
                                          hintText: 'Last Name',
                                          hintStyle: TextStyle(
                                            color: klabelTextColor
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5)
                                      ]),
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: validateEmail,
                                    onSaved: (val) => email = val,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.mark_email_read_rounded,
                                        color: klabelTextColor.withOpacity(0.5),
                                      ),
                                      hintText: 'E_mail',
                                      hintStyle: TextStyle(
                                        color: klabelTextColor.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5)
                                      ]),
                                  child: TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    validator: validateMobile,
                                    onSaved: (val) => phone = val,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.phone,
                                        color: klabelTextColor.withOpacity(0.5),
                                      ),
                                      prefix: Text('+963'),
                                      hintText: 'Phone Number',
                                      hintStyle: TextStyle(
                                        color: klabelTextColor.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),

                                //------------------------------button Sign Up----------------

                                SizedBox(height: 40),
                                ReusableRaisedButton(
                                  onpressed: () {
                                    register();
                                  },
                                  text: 'SignUp',
                                  color: kButtongradientColor,
                                ),
                                //------------------------------button login----------------

                                SizedBox(height: 20),

                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.grey.withOpacity(0.3),
                                        )
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      'You have an Account ? Sign_IN',
                                      style: TextStyle(color: klabelTextColor),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Loading..."),
                ],
              )
              // )
              ),
    );
  }
  //------------------------Validation-----------------------------------------

  String validateMobile(String value) {
    if (value.length == 0)
      return 'Please enter PhoneNumber';
    else if (value.length != 9)
      return 'Mobile Number Must be like (+963-9********)';
    else
      return null;
  }

  String validateEmail(String value) {
    if (value.length == 0)
      return 'Please enter your Email';
    else if (!EmailValidator.validate(value))
      return 'Please enter a valid Email';
    else
      return null;
  }
}
