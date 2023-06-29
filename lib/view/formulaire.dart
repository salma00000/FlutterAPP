import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pfe_project/services/form.dart';
import 'package:pfe_project/view/ChatScreen.dart';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'dart:convert';
import 'liste.dart';
import 'package:pfe_project/services/products.dart';
import 'package:pfe_project/services/auth.dart';

import 'package:provider/provider.dart';

class formd extends StatefulWidget {
  @override
  _formdState createState() => _formdState();
}

enum SingingCharacter { Problemes_logiciels, Problemes_materiels }

class _formdState extends State<formd> {
  SingingCharacter? _character = SingingCharacter.Problemes_logiciels;

  var datee = "";
  var base = "";
  File? image;
  // final imagepicker = ImagePicker();
  // uploadImage() async {
  // var pickedImage = await imagepicker.pickImage(source: ImageSource.gallery,maxHeight: 50,maxWidth: 50);
  //if (pickedImage != null) {
  //setState(() async {
  //image = File(pickedImage.path);
  //Uint8List  imagebytes =  await pickedImage.readAsBytes();
  //String base64string = base64.encode(imagebytes); //convert bytes to base64 string
  //print(base64string);
  //this.base=base64string;
  //});
  //} else {}
  //}
  final _formKey = GlobalKey<FormState>();
  String? _token;

  var _problem = TextEditingController();
  String? _nomProduitController;
  List<String>? _listProducts;

  void ListMyProducts() async {
    var token = Provider.of<Auth>(context, listen: false).token;
    _token = token;
    print(token);
    var product =
        await Provider.of<Products>(context, listen: false).list(token);
    print('bye');
    print(product);
    _listProducts = product;
  }

  @override
  void initState() {
    super.initState();
    ListMyProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 50),
        width: 500,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('images/form.png'),
            opacity: 0.5,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Center(
                    child: Text('VEUILLEZ COMPLÉTER CE FORMULAIRE',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "Afin de vous aider, veuillez utiliser le formulaire suivant ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: RadioListTile<SingingCharacter>(
                      title: Text('Problèmes logiciels'),
                      value: SingingCharacter.Problemes_logiciels,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: RadioListTile<SingingCharacter>(
                      title: Text('Problèmes matériels'),
                      value: SingingCharacter.Problemes_materiels,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      }),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButton<String>(
                        value: _nomProduitController,
                        onChanged: (String? newValue) {
                          setState(() {
                            _nomProduitController = newValue!;
                          });
                        },
                        items: _listProducts
                            ?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _problem,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            hintText: "Description du problème :",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                ))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                color: Colors.blueGrey,
                              ),
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey,
                                ),
                                onPressed: () {
                                  String? character;
                                  if (_character ==
                                      SingingCharacter.Problemes_materiels) {
                                    character = "problem materiel";
                                  } else if (_character ==
                                      SingingCharacter.Problemes_logiciels) {
                                    character = "problem logiciel";
                                  }
                                  Map data = {
                                    "nom_produit": _nomProduitController,
                                    "description_probleme": _problem.text,
                                    "type_probleme": character,
                                  };

                                  Provider.of<SendForm>(context, listen: false)
                                      .send(data, _token);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                              title:
                                                  'Votre formulaire a bien été envoyé. Vous recevrez bientôt une notification par e-mail !')));
                                },
                                child: Text(
                                  "ENVOYER LE FORMULAIRE",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
