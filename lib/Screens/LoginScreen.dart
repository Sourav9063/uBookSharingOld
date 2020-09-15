import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
// import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uBookSharing/Components/CompoundWidgets.dart';
import 'package:uBookSharing/Constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool animationUnloack = false;
  String _email;
  String _password;
  double aPEmail = 50;
  double aPPassword = 50;
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

  void signIn(String email, String password) async {
    try {
    UserCredential userCredential  =await auth.signInWithEmailAndPassword(email: email, password: password);
      
  userCredential.credential.

    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return alerts(e.code);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/BookBack.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: FlareActor(
                  'assets/flr/lockStates.flr',
                  animation: !animationUnloack ? 'play_lock' : 'unlock',
                  color: Colors.pinkAccent.shade400,
                )),
            Expanded(
                flex: 1,
                child: Text(
                  'Sign In',
                  style: GoogleFonts.abrilFatface(
                    fontSize: 40,
                    // fontWeight: FontWeight.bold,

                    color: Colors.pinkAccent.shade400,
                  ),
                )),
            Expanded(
              flex: 5,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimatedPadding(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      padding: EdgeInsets.symmetric(
                          horizontal: aPEmail, vertical: 0),
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
                                  'Sign In',
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),

                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              onPressed: () {
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
                                if (isAlright) signIn(_email, _password);
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
      ),
    );
  }
}
