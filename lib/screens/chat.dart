import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void setupPushNotifications() async {
    final fbm = FirebaseMessaging.instance;
    await fbm.requestPermission();
    fbm.subscribeToTopic('chat');
    print('jestem');
  }

  @override
  initState() {
    super.initState();
    setupPushNotifications();
  }

  _handleClick(int item) {
    if (item == 0) {
      FirebaseAuth.instance.signOut();
    }
    if (item == 1) {
      FirebaseAuth.instance.currentUser!.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          PopupMenuButton(
            onSelected: (item) => _handleClick(item),
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: 0,
                child: Text('Logout'),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text('Delete Account'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
