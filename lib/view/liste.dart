import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List<bool> formStates = [false, false, false];
  List<String> formDescriptions = []; // List to store form descriptions

  Future<List<String>> getData() async {
  var url = Uri.parse('http://127.0.0.1:8080/formulaires'); // API endpoint URL

  var response = await http.get(url);

  if (response.statusCode == 200) {
    // Request was successful
    var responseData = response.body;
    List<String> descriptions = parseResponseData(responseData);
    print(descriptions); // Print the parsed descriptions
    return descriptions;
  } else {
    // Request failed
    throw Exception('Failed to fetch forms');
  }
}

List<String> parseResponseData(String responseData) {
  List<dynamic> jsonData = jsonDecode(responseData);
  List<String> descriptions = jsonData.map((item) => item['descriptionProbleme'].toString()).toList();
  print(jsonData); // Print the parsed JSON data
  return descriptions;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Liste Des Formulaires',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FutureBuilder<List<String>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<String> descriptions = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: descriptions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.assignment),
                          title: Text(descriptions[index]),
                          trailing: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (formStates[index]) {
                                      formStates[index] = false;
                                    } else {
                                      formStates[index] = true;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: formStates[index]
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                child: Text(formStates[index]
                                    ? 'Traité'
                                    : 'Non traité'),
                              ),
                              const SizedBox(width: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  // Implement the functionality for the "renvoyer" button
                                },
                                child: const Text("renvoyer"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
