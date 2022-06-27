import 'package:at_chat_flutter/at_chat_flutter.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen(this.title, {Key? key}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    // * This is a simple wrapper around the at_chat_flutter [ChatScreen]
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: ChatScreen(
        height: MediaQuery.of(context).size.height,
        title: title,
        isScreen: true,
        incomingMessageColor: Colors.green[200]!,
        outgoingMessageColor: Colors.blue[200]!,
      ),
    );
  }
}
