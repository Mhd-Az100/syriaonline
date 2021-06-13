import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syriaonline/screen/page%20choose.dart';
import 'package:syriaonline/screen/page%20signUp.dart';
import 'package:syriaonline/service/loginpost.dart';
import 'package:syriaonline/service/postemail.dart';
import 'package:syriaonline/widgets/signup/signuprawMaterialButton.dart';
import 'package:syriaonline/utils/allUrl.dart';
import '../constant/constent.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var loginEmailController = TextEditingController();
  var loginCodeController = TextEditingController();
  String loginEmail, _code = "";
  final loginformKey = new GlobalKey<FormState>();
  bool state = true;
  @override
  void initState() {
    super.initState();
  }

  bool result1 = false;
  bool result2 = false;
  senddata(context, Map map) async {
    result1 = await loginpost(registerCod, map, context);
    result1
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ChoosePage(),
            ),
          )
        : Fluttertoast.showToast(
            timeInSecForIosWeb: 2,
            backgroundColor: Color(0xE1D32323),
            msg: 'error in your\n Email OR Code',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);

    print("result 1 $result1");
    return result1;
  }

  sendemail(context, Map map) async {
    result2 = await postemail(login, map);
    print("result 2  $result2");
    return result2;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: kchooseColor,
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
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child: Text(
                      'LogIn',
                      style: kTitleText,
                    )),
                    Column(children: [
                      Form(
                        key: loginformKey,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "   E_mail:",
                                  style: TextStyle(
                                    color: klabelColor,
                                    fontFamily: "Raleway",
                                    fontSize: 20,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10.0)),
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
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5)
                                      ]),
                                  child: TextFormField(
                                    enabled: state,
                                    controller: loginEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: validateEmail,
                                    onSaved: (val) => loginEmail = val,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(
                                          Icons.mark_email_read_rounded,
                                          color:
                                              klabelTextColor.withOpacity(0.5),
                                        ),
                                        hintText: ' Enter Your E_mail',
                                        hintStyle: TextStyle(
                                          color:
                                              klabelTextColor.withOpacity(0.5),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.send_rounded,
                                            color: klabelTextColor
                                                .withOpacity(0.5),
                                          ),
                                          onPressed: () {
                                            Map addEmail = {
                                              "e_mail":
                                                  loginEmailController.text,
                                            };
                                            setState(() {
                                              state = false;
                                              sendemail(context, addEmail);
                                              print(addEmail);
                                              Fluttertoast.showToast(
                                                  timeInSecForIosWeb: 2,
                                                  backgroundColor:
                                                      Color(0xE139B84E),
                                                  msg:
                                                      'Send Code for your Gmail',
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM);
                                            });
                                          },
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  "   Code:",
                                  style: TextStyle(
                                    color: klabelColor,
                                    fontFamily: "Raleway",
                                    fontSize: 20,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10.0)),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 59,
                                  padding: EdgeInsets.only(
                                      top: 4, left: 16, right: 16, bottom: 4),
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
                                    enabled: !state,
                                    // obscureText: true,
                                    controller: loginCodeController,
                                    keyboardType: TextInputType.number,
                                    validator: validateCode,
                                    onSaved: (val) => _code = val,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        Icons.security,
                                        color: klabelTextColor.withOpacity(0.5),
                                      ),
                                      hintText: ' Enter Your Code',
                                      hintStyle: TextStyle(
                                        color: klabelTextColor.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(3.0)),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        state = true;
                                        Fluttertoast.showToast(
                                            msg: 'Send Email Again',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM);
                                      });
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
                                        'Not received any Code ?',
                                        style:
                                            TextStyle(color: Colors.grey[850]),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10.0)),
                                Center(
                                  child: ReusableRaisedButton(
                                    onpressed: () {
                                      if (loginformKey.currentState
                                          .validate()) {
                                        setState(() {
                                          Map sendcode = {
                                            "e_mail": loginEmailController.text,
                                            "Code": loginCodeController.text,
                                          };
                                          senddata(context, sendcode);
                                          print('sendcode $sendcode');
                                        });
                                      }
                                    },
                                    text: 'LogIn',
                                    color: kButtongradientColor,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 2.0)),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => SignUP(),
                                        ),
                                      );
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
                                        'You Don`t Have an Account ? Sign_Up',
                                        style:
                                            TextStyle(color: klabelTextColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  //------------------------Validation-----------------------------------------

  String validateEmail(String value) {
    if (value.length == 0)
      return 'Please enter your Email';
    else if (!EmailValidator.validate(value))
      return 'Please enter a valid Email';
    else
      return null;
  }

  String validateCode(String value) {
    if (value.length == 0)
      return 'Please enter your Email';
    else if (value.length != 6)
      return 'Code must be 6 numbers';
    else
      return null;
  }
}
