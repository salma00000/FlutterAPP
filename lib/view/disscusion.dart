import'package:flutter/material.dart';
class disscusion extends StatefulWidget {
  @override
  _disscusionState createState() => _disscusionState();
}
class _disscusionState extends State<disscusion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Center(
        child: Container(
          width: 500,
          height: 500,

          color: Colors.pink,
          child: Text("disscusion ici",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        ),
      ),

    );
  }
}
