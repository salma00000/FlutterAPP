import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pfe_project/services/auth.dart';
import 'package:pfe_project/services/user.dart';
import 'package:pfe_project/services/chat.dart';

import 'package:pfe_project/services/chatbot.dart';
import 'package:pfe_project/view/formulaire.dart';

import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  String? title;

  ChatScreen({Key? key, this.title}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  String? nom;

  void _handleSubmitted(String text) async {
    var user = Provider.of<Auth>(context, listen: false).user;

    var token = Provider.of<Auth>(context, listen: false).token;

    var chatbot =
        await Provider.of<Chat>(context, listen: false).list(token, text);

    if (user?.nom != null) {
      nom = user?.nom;
    } else {
      nom = 'vous';
    }
    _textController.clear();
    ChatMessage message =
        ChatMessage(text: text, sender: nom.toString(), type: 'all');
    setState(() {
      _messages.insert(0, message);
    });

    // Add code here to send text to Dialogflow and receive response

    ChatMessage botMessage = ChatMessage(
      text: chatbot.toString(),
      sender: "assistance bot",
      type: 'bot',
    );
    setState(() {
      _messages.insert(0, botMessage);
    });

    if (chatbot ==
        "Je n'ai pas pu trouver de réponse. Veuillez remplir ce formulaire afin que nous puissions trouver une solution à votre problème, s'il vous plaît.") {
      Future.delayed(Duration(seconds: 6), () {
        // Executed after 10 seconds
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => formd()));
      });
    }
  }

  void IfSendedForm(title) {
    if (title != null && title.isEmpty == false) {
      ChatMessage botMessage = ChatMessage(
        text: title.toString(),
        sender: 'assistance bot',
        type: 'bot',
      );
      setState(() {
        _messages.insert(0, botMessage);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    IfSendedForm(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatbot"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration: InputDecoration.collapsed(
                      hintText: "envoyer un message",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;
  final String type;
  bool isClient = true;

  ChatMessage({required this.text, required this.sender, required this.type});

  @override
  Widget build(BuildContext context) {
    if (type == 'bot') {
      isClient = false;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: Visibility(
              visible:
                  isClient, // Replace 'condition' with your actual condition
              child: CircleAvatar(
                child: Text(sender[0]),
              ),
              replacement: CircleAvatar(
                backgroundImage: AssetImage(
                    'images/logo.jpg'), // Replace with the actual path to your image
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                sender,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Text(text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
