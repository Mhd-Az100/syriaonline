import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page%20choose.dart';
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

  //-------------------------register sign up ----------------------------------

  void register() async {
    if (signupformKey.currentState.validate()) {
      var url = Uri.parse(account);
      setState(() {
        loading = true;
      });
      var data = {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "e_mail": emailController.text,
        "user_phone_number": phoneController.text,
        "passowrd": passwordController.text,
        'account_type_id': '2',
      };

      http.Response res = await http.post(url, body: data);
      var resbody = jsonDecode(res.body);

      savepref(resbody['first_name'], resbody['last_name'], resbody['e_mail'],
          resbody['account_id']);

      setState(() {
        loading = false;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ChoosePage(),
        ),
      );
    }
  }

  //------------------shared preferences----------------------------------------
  savepref(
      String firstName, String lastName, String email, int accountId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('first_name', firstName);
    preferences.setString('last_name', lastName);
    preferences.setString('e_mail', email);
    preferences.setString('account_id', accountId.toString());

    // مشان اتاكد
    print(preferences.getString('first_name'));
    print(preferences.getString('last_name'));
    print(preferences.getString('e_mail'));
    print(preferences.getString('account_id'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (loading == false)
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: kBackTextColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                      ),
                      child: Text(
                        'Sign Up',
                        style: kTitleText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Form(
                        key: signupformKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 59,
                                padding: EdgeInsets.only(
                                    top: 8, left: 16, right: 16, bottom: 4),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
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
                                      color: klabelTextColor.withOpacity(0.5),
                                    ),
                                    hintText: 'First Name',
                                    hintStyle: TextStyle(
                                      color: klabelTextColor.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 59,
                                padding: EdgeInsets.only(
                                    top: 8, left: 16, right: 16, bottom: 4),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
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
                                      color: klabelTextColor.withOpacity(0.5),
                                    ),
                                    hintText: 'Last Name',
                                    hintStyle: TextStyle(
                                      color: klabelTextColor.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 59,
                                padding: EdgeInsets.only(
                                    top: 8, left: 16, right: 16, bottom: 4),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
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
                                height: 59,
                                padding: EdgeInsets.only(
                                    top: 8, left: 16, right: 16, bottom: 4),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
                                    ]),
                                child: TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.number,
                                  validator: validateMobile,
                                  //  (val) => val.length == 0
                                  //     ? 'Please Enter Your Phone Number'
                                  //     : null,
                                  onSaved: (val) => phone = val,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.phone,
                                      color: klabelTextColor.withOpacity(0.5),
                                    ),
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
                                child: Text(
                                  'You Dont Have an Account ? Sing_IN',
                                  style: TextStyle(color: klabelTextColor),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
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
      ),
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

  String validateEmail(String value) {
    if (value.length == 0)
      return 'Please enter your Email';
    else if (!EmailValidator.validate(value))
      return 'Please enter a valid Email';
    else
      return null;
  }
}
