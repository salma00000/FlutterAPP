import 'package:flutter/material.dart';
import 'package:pfe_project/view//login.dart';
import 'package:get/get.dart';
import 'package:pfe_project/view/ChatScreen.dart';
import 'package:pfe_project/view/disscusion.dart';
import 'package:pfe_project/view/liste.dart';

import 'code.dart';

class choix extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _choixState();
  }
}

class _choixState extends State<choix> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 120),
              child: Image.asset('images/choix2.png'),
            ),
            Container(
              width: 270,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2D1AFF),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                child: Text(
                  "ouvrir une discussion avec chatbot  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 270,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2D1AFF),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyList()));
                },
                child: Text(
                  "Consulter ma liste de formulaires de réclamations ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
