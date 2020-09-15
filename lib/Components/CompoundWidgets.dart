import 'package:flutter/material.dart';

class IconAccount extends StatelessWidget {
  const IconAccount({
    @required this.radious,
    Key key,
  }) : super(key: key);
  final double radious;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.lightBlue,
      // color: Colors.blue.shade200,
      // color: Colors.white,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          gradient: RadialGradient(colors: [
            // Colors.pinkAccent.shade100,
            // Colors.pinkAccent.shade100,
            Colors.pinkAccent.shade400,
            Colors.indigoAccent.shade100
          ])),
      height: radious,
      width: radious,
      child: Icon(
        Icons.account_circle,
        size: radious,
        color: Colors.white,
      ),
    );
  }
}

class Alarts {}

class IconAccountOld extends StatelessWidget {
  const IconAccountOld({
    @required this.radious,
    Key key,
  }) : super(key: key);
  final double radious;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        // color: Colors.lightBlue,
        // color: Colors.blue.shade200,
        // color: Colors.white,
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
          // Colors.pinkAccent.shade100,
          Colors.pinkAccent.shade400,
          Colors.indigoAccent.shade100
        ])),
        height: radious,
        width: radious,
        child: Icon(
          Icons.account_circle,
          size: radious,
          color: Colors.white,
        ),
      ),
    );
  }
}
