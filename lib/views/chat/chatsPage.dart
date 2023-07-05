import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../services/chatService.dart';
import 'chatPage.dart';

class ChatsPage extends StatefulWidget {
  
  var userData;
  
  ChatsPage({Key? key, this.userData}) : super(key: key);
  
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
        title: Text(
          'Chats',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: _chatService.getAllChatsForCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xff6527BE),
                backgroundColor: Color(0xffB28CFF),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            );
          }

          final chatIds = snapshot.data;
          print('chatIds: $chatIds');

          if (chatIds == null || chatIds.isEmpty) {
            return Center(
              child: Text(
                'No chats found.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
              return FutureBuilder<Map<String, dynamic>>(
                future: _chatService.getOtherUserData(otherUserId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return ListTile(
                      title: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }

                  final otherUserData = snapshot.data;
                  print('otherUserData: $otherUserData');
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          otherUserData!['name'] ?? 'No name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Tap to open chat',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: ClipOval(
                            child: Image.network(
                              otherUserData['photo'] ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.to(
                            ChatPage(
                              userId: _chatService.getCurrentUserId(),
                              otherUserId: otherUserId,
                            ),
                          );
                        },
                      ),
                    ),
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
