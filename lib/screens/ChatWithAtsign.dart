import 'package:at_chat_flutter/at_chat_flutter.dart';
import 'package:flutter/material.dart';

class ChatWithAtsign extends StatefulWidget {
  static final String id = 'ChatWithAtsign';
  @override
  _ChatWithAtsignState createState() => _ChatWithAtsignState();
}

class _ChatWithAtsignState extends State<ChatWithAtsign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      // TODO: Fill in the body parameter of the Scaffold
      body: ChatScreen(
        height: MediaQuery.of(context).size.height,
        incomingMessageColor: Colors.blue[100],
        outgoingMessageColor: Colors.green[100],
        isScreen: true,
      ),
    );
  }
}
