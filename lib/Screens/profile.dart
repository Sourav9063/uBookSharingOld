import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uBookSharing/BackEnd/Datas.dart';
import 'package:uBookSharing/BackEnd/UploadIMG.dart';
import 'package:uBookSharing/Components/CompoundWidgets.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserProfileData currentData = UserProfileData();

  upLoadData() async {
    // print(UserLogInData.uid);
    currentData.versityName = currentData.versityName.toUpperCase().trim();
    try {
      await FirebaseFirestore.instance
          .collection(currentData.versityName)
          .doc('USER')
          .collection('UserCollections')
          .doc(UserLogInData.uid)
          .set(currentData.getMap());

      // currentData.name, currentData.versityName,
      // 'profilePicLink', 'admitted', 'dept', 'phoneNum', 'email'

      // Map afda = currentData.getMap(currentData.name, currentData.versityName,
      //     'profilePicLink', 'admitted', 'dept', 'phoneNum', 'email');
      // print(afda[AllKeys.nameKey]);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertsCompound(
            msg: 'Something Wrong',
            color: Colors.red.shade200,
            des: e.code.replaceAll(RegExp('-'), ' '),
            buttonTxt: 'OK',
            function: () {
              // spinner = false;
              Navigator.pop(context);
            },
          );
        },
      );
      print(e.code);
    }
  }

  int rand = 1;
  Alignment alb = Alignment.bottomLeft;
  Alignment ale = Alignment.topRight;
  void gredianAlign() {
    rand = Random().nextInt(5) + 1;

    setState(() {
      if (rand == 1) {
        alb = Alignment.bottomLeft;
        ale = Alignment.topRight;
      }

      if (rand == 2) {
        ale = Alignment.bottomLeft;
        alb = Alignment.topRight;
      }

      if (rand == 3) {
        alb = Alignment.bottomRight;
        ale = Alignment.topLeft;
      }
      if (rand == 4) {
        ale = Alignment.bottomRight;
        alb = Alignment.topLeft;
      }
      if (rand == 5) {
        ale = Alignment.centerLeft;
      }
      if (rand == 6) {
        alb = Alignment.centerRight;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
          duration: Duration(milliseconds: 700),
          curve: Curves.fastOutSlowIn,
          height: CommonThings.size.height,
          width: CommonThings.size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff000000),
                Color(0xff373b5f),
                // rand % 2 == 1 ? Colors.indigo : Colors.red,

                Color(0xffa9418b),

                // Colors.white
              ],
              begin: alb,
              end: ale,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: 1000,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // color: Colors.white38,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                // color: Colors.white30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RaisedButton(
                      child: Text('User'),
                      onPressed: () async {
                        await UploadIMG().getUserPic();
                        final link =
                            await UploadIMG().uploadUserPic(UserLogInData.uid);
                        print(link);
                      },
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.account_circle),
                              
                              // icon: Icon(Icons.account_circle,size:,),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onChanged: (value) {
                              currentData.versityName = value;
                            },
                          ),
                          TextFormField(
                            onChanged: (value) {
                              currentData.name = value;
                            },
                          ),
                          RaisedButton(
                            onPressed: () {
                              gredianAlign();
                              // upLoadData();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
