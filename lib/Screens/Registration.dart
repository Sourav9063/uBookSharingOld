import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uBookSharing/BackEnd/Datas.dart';
import 'package:uBookSharing/Components/CompoundWidgets.dart';

import 'package:uBookSharing/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uBookSharing/Screens/profile.dart';

class RegScreen extends StatefulWidget {
  RegScreen({Key key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  
  bool animationUnloack = false;
  String _email = '';
  String _password = '';
  bool verified = false;
  double aPEmail = 50;
  double aPPassword = 50;

  String verifyButtonText = 'Verify Email';
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  AlertDialog alerts(String error) {
    error = error.replaceAll(RegExp('-'), ' ');

    AlertDialog alert = AlertDialog(
      title: Text('Error'),
      content: Text(error),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            // setState(() {
            //   showSpinner = false;
            // });
            Navigator.pop(context);
          },
        )
      ],
    );
    return alert;
  }

  AlertDialog veryfyEmailAlertDialog() {
    AlertDialog alert = AlertDialog(
      title: Text('Email Verification'),
      content: Text('Check your email and click the link to verify'),
      actions: <Widget>[
        FlatButton(
          child: Text('Check'),
          onPressed: () async {
             verifiedCheck();
            if (verified) Navigator.pop(context);
          },
        )
      ],
    );
    return alert;
  }

  void signUn(String email, String password) async {
    //  _email!=''? verifiedCheck():null;
    try {
      UserCredential uc = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await auth.currentUser.sendEmailVerification();

      verifiedCheck();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return veryfyEmailAlertDialog();
          });

      UserDataSavedEmailPassword.saveuidSharedPref(auth.currentUser.uid);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return alerts(e.code);
        },
      );
    }
    verifiedCheck();
  }

  void verifiedCheck() async {
    await auth.currentUser.reload();
    setState(() {
      verified = auth.currentUser.emailVerified;
      if (verified) verifyButtonText = 'Email verified';
      // print(verified);
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          Container(
            height: CommonThings.size.height,
            width: CommonThings.size.width,
            // duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              image: DecorationImage(
                  // scale: .4,
                  alignment: Alignment.bottomRight,
                  image: AssetImage('assets/img/BookBack.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          // FlareActor(
          //   'assets/flr/Background.flr',
          //   animation: 'Flow',
          //   fit: BoxFit.cover,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Center(
                      // right: CommonThings.size.width * .05,
                      // top: 200,
                      child: IconAccount(
                        radious: 150,
                      ),
                    ),
                  ),
                  AnimatedPadding(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    padding:
                        EdgeInsets.symmetric(horizontal: aPEmail, vertical: 0),
                    child: TextFormField(
                      // autovalidate: true,
                      validator: (value) {
                        if (value == '' || value == null)
                          return 'Enter Email address';
                        else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) return 'Invalid Email';

                        return null;
                      },
                      onTap: () {
                        setState(() {
                          aPEmail = 10;
                          //  aPEmail = 50;
                          aPPassword = 50;
                        });
                      },
                      // onSubmitted: (value) {
                      //   setState(() {
                      //     aPEmail = 50;
                      //   });

                      //   _email = value;
                      // },
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email', labelText: 'Email'),
                    ),
                  ),
                  AnimatedPadding(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    padding: EdgeInsets.symmetric(
                        horizontal: aPPassword, vertical: 8),
                    child: TextFormField(
                      onTap: () {
                        setState(() {
                          aPPassword = 10;
                          aPEmail = 50;
                          // aPPassword = 50;
                        });
                      },
                      validator: (value) {
                        if (value.length < 6)
                          return 'Can\'t you read!? At least 6 characters';

                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        _password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          // errorText: _email,

                          hintText: 'Enter your password(atleast 6 digits)',
                          labelText: 'Password'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          // duration: Duration(milliseconds: 200),
                          flex: 2,
                          child: RaisedButton(
                            // focusColor: Colors.pinkAccent.shade400,

                            // focusColor: Colors.pinkAccent.shade400,

                            child: Center(
                              child: Text(
                                verifyButtonText,
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),

                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            onPressed: verified
                                ? null
                                : () {
                                    setState(() {
                                      aPEmail = 50;
                                      aPPassword = 50;
                                    });
                                    bool isAlright =
                                        _formKey.currentState.validate();
                                    // print(auth.currentUser.uid);
                                    // auth.currentUser.uid != null
                                    //     ? signUn(_email, _password)
                                    //     : verifiedCheck();
                                    if (isAlright) signUn(_email, _password);
                                  },
                          ),
                        ),
                        Expanded(
                          flex: verified ? 2 : 1,
                          // duration: Duration(milliseconds: 200),
                          child: RaisedButton(
                            // focusColor: Colors.pinkAccent.shade400,

                            // focusColor: Colors.pinkAccent.shade400,

                            child: Text(
                              'Next',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 18, color: Colors.white),
                            ),
                            color: Colors.green,

                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            onPressed: !verified
                                ? null
                                : () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfile()));
                                  },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
