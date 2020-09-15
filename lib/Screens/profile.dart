import 'package:flutter/material.dart';
import 'package:uBookSharing/BackEnd/UploadIMG.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        RaisedButton(
          child: Text('User'),
          onPressed: () async {
            await UploadIMG().getBookPic();
            final link = await UploadIMG()
                .uploadBookPic('aldsfkjaf;kasjfaoejfnaenfoaajfjjajs');
            print(link);
          },
        )
      ],
    ));
  }
}
