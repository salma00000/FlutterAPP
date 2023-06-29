import 'package:flutter/material.dart';
import 'package:pfe_project/view/choix.dart';
import 'package:pfe_project/view/liste.dart';
import 'package:pfe_project/view/ChatScreen.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pfe_project/services/auth.dart';
import 'package:flutter/src/widgets/form.dart';

class login extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _loginState();
  }
}

class _loginState extends State<login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController.text = '';
    _passwordController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 350,
            child: Image.asset('images/b.png'),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (String? value) => value != null && value.isEmpty
                        ? 'please enter email'
                        : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Entrer Email",
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
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    validator: (String? value) => value != null && value.isEmpty
                        ? 'please entrer password'
                        : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Entrer mot de passe",
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
                  SizedBox(
                    height: 20,
                  ),
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
                          Map creds = {
                            'email': _emailController.text,
                            'password': _passwordController.text,
                            'device_name': 'mobile',
                          };

                          if (_formKey.currentState!.validate()) {
                            Provider.of<Auth>(context, listen: false)
                                .login(creds);

                            if (Provider.of<Auth>(context, listen: false)
                                .authenticated)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => choix()));
                          }
                        },
                        child: Text(
                          "CONNEXION",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
