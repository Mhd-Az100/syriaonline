import 'package:flutter/material.dart';
import 'package:syriaonline/screen/page%20choose.dart';
import 'package:syriaonline/screen/pagesignUp.dart';
import 'package:syriaonline/widgets/signup/signuprawMaterialButton.dart';
import '../constant/constent.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var loginEmailController = TextEditingController();
  var loginCodeController = TextEditingController();
  String loginEmail, loginPass;
  final loginformKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
                                controller: loginEmailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) => val.length == 0
                                    ? 'Please Enter Your Email'
                                    : null,
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
                                        print('Done');
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
                                keyboardType: TextInputType.text,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'please enter your code';
                                  }
                                },
                                onSaved: (val) => loginPass = val,
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
                                onPressed: () {},
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
                                  if (loginformKey.currentState.validate())
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => ChoosePage(),
                                      ),
                                    );
                                },
                                text: 'LogIn',
                                color: kgradientColor,
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
}
