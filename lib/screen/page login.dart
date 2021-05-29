import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syriaonline/screen/page%20choose.dart';
import 'package:syriaonline/screen/page%20signUp.dart';
import 'package:syriaonline/service/loginpost.dart';
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
    result1 = await loginpost(registerCod, map);
    print("result  $result1");
    return result1;
  }

  sendemail(context, Map map) async {
    result2 = await loginpost(login, map);
    print("result  $result2");
    return result2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text(
          'Wellcome You',
          style: kTitleAppbarStyle,
        ),
        elevation: 5,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    'Log In',
                    style: kTitleText,
                    textAlign: TextAlign.center,
                  ),
                ),
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
                                        color: Colors.black12, blurRadius: 5)
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
                                      color: klabelTextColor.withOpacity(0.5),
                                    ),
                                    hintText: 'Please Enter Your E_mail',
                                    hintStyle: TextStyle(
                                      color: klabelTextColor.withOpacity(0.5),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.send_rounded,
                                        color: klabelTextColor.withOpacity(0.5),
                                      ),
                                      onPressed: () {
                                        Map addEmail = {
                                          "e_mail": loginEmailController.text,
                                        };
                                        setState(() {
                                          state = false;
                                          sendemail(context, addEmail);
                                          print(addEmail);
                                          // uploadimg();
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
                                        color: Colors.black12, blurRadius: 5)
                                  ]),
                              child: TextFormField(
                                obscureText: true,
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
                                  hintText: 'Please Enter Your Code',
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
                                child: Text(
                                  'Not received any Code ?',
                                  style: TextStyle(color: klabelTextColor),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10.0)),
                            Center(
                              child: ReusableRaisedButton(
                                onpressed: () {
                                  if (loginformKey.currentState.validate()) {
                                    Map sendcode = {
                                      "e_mail": loginEmailController.text,
                                      "Code": loginCodeController.text,
                                    };
                                    setState(() {
                                      senddata(context, sendcode);
                                      print('sendcode $sendcode');
                                    });
                                    if (result2 == true) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => ChoosePage(),
                                        ),
                                      );
                                      result2 = false;
                                    }
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SignUP(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'You Dont Have an Account ? Sing_Up',
                                  style: TextStyle(color: klabelTextColor),
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
