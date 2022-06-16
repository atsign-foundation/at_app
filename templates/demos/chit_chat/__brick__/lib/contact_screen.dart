import 'package:at_chat_flutter/at_chat_flutter.dart';
import 'package:at_contacts_flutter/at_contacts_flutter.dart';
import 'package:flutter/material.dart';

import 'chats_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return ContactsScreen(
      // * When the send icon is pressed for a particular contact
      onSendIconPressed: (String atsign) {
        // * Set the [atsign] that you will be chatting with on the chat screen
        setChatWithAtSign(atsign);
        // * Then go to the chat screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChatsScreen(atsign);
          }),
        );
      },
    );
  }
}
