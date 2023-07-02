import 'package:doctor/views/chat/chatPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../services/chatService.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late ChatService _chatService;

  @override
  void initState() {
    super.initState();
    _chatService = ChatService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6527BE),
        title: Text('Chats',),
      ),
      body: FutureBuilder<List<String>>(
        future: _chatService.getAllChatsForCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final chatIds = snapshot.data;
          print('chatIds: $chatIds');

          if (chatIds == null || chatIds.isEmpty) {
            return Center(
              child: Text('No chats found.'),
            );
          }

          return ListView.builder(
            itemCount: chatIds.length,
            itemBuilder: (context, index) {
              final chatId = chatIds[index];
              String otherUserId = '';
              String currentUserId = _chatService.getCurrentUserId();
              List<String> users = chatId.split('_');
              if (users[0] == currentUserId) {
                otherUserId = users[1];
              } else {
                otherUserId = users[0];
              }
              return FutureBuilder<String>(

                future: _chatService.getOtherUserName(otherUserId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text('Loading...'),
                    );
                  }


                  if (snapshot.hasError) {
                    return ListTile(
                      title: Text('Error: ${snapshot.error}'),
                    );
                  }

                  final otherUserName = snapshot.data;
                  print('otherUserName: $otherUserName');
                  return ListTile(
                    title: Text(otherUserName ?? 'Unknown User'),
                    onTap: () {
                      Get.to(
                        ChatPage(
                          userId: _chatService.getCurrentUserId(),
                          otherUserId: otherUserId,
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
