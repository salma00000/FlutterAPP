import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pfe_project/view/choix.dart';
import 'package:pfe_project/view/login.dart';

import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pfe_project/services/auth.dart';

import '../../helpers/Strings.dart';

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  late PageController _pageController;
  int currentIndex = 0;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  void readToken() async {
    String token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).tryToken(token: token);
    // ignore: use_build_context_synchronously
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigateToNextPage() {
    Get.to(() => login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20, top: 20),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => login()));
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: [
                makePage(
                  image: 'images/welcome1.png',
                  title: Strings.stepThreeTitle,
                  content: Strings.stepThreeContent,
                ),
                makePage(
                  reverse: true,
                  image: 'images/welcome2.png',
                  title: Strings.stepOneTitle,
                  content: Strings.stepOneContent,
                ),
                makePage(
                  image: 'images/welcome3.png',
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildIndicator(),
              ),
            ),
          ],
        ));
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !reverse
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(image),
                    ),
                    SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ],
                )
              : SizedBox(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF3489db),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          reverse
              ? Column(
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                  ],
                )
              : SizedBox(
                  width: 10,
                  height: 10,
                ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 30 : 8,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
