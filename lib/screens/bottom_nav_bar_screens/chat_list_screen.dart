import 'package:flutter/material.dart';
import 'package:maveshi/screens/chat/chat_profile_screen.dart';

class ChatListScreen extends StatelessWidget {
  static const routeName = 'chat-screen';
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with the actual number of messages
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatProfileScreen()));
                  },
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('sender_profile_image_url'),
                  ),
                  title: const Text('Farooq Ahmad'),
                  subtitle: const Text('hi,how are you'),
                  trailing: const Text(
                      '10:00 AM'), // Replace with the message timestamp
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
