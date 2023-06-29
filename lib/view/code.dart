import 'package:flutter/material.dart';
import 'package:pfe_project/view/ChatScreen.dart';
import 'package:get/get.dart';
class code extends StatefulWidget{
  State<StatefulWidget> createState() {
    return _loginState();
  }
}
class _loginState extends State<code> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(top: 20),
                height: 350,
                child: Image.asset('images/titre.png'),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Form(child: Column(children: [
                  TextFormField(

                    decoration:
                    InputDecoration(
                      prefixIcon: Icon(Icons.dialpad),
                      labelText: "Enter code",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),


                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        color: Colors.blue,
                      ),
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen ()));
                        },
                        child:
                        Text("CONNEXION", style: TextStyle(fontSize: 20,
                            color: Colors.white),),
                      )
                  ),
                ],
                ),
                ),
              ),
            ]
        ),
      ),
    );
  }}