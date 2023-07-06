import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../services/chatService.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String otherUserId;

  const ChatPage({required this.userId, required this.otherUserId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late ChatService _chatService;
  late Stream<QuerySnapshot> _messagesStream;
  final ScrollController _scrollController = ScrollController();

  // Get the name of the other user from Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> getOtherUserName() async {
    String otherUserName = '';

    // Check the "users" collection
    final userDocument =
    await firestore.collection('users').doc(widget.otherUserId).get();
    if (userDocument.exists && userDocument.data()!.containsKey('name')) {
      otherUserName = userDocument.data()!['name'];
    }

    // Check the "doctors" collection if the name is not found in "users"
    if (otherUserName.isEmpty) {
      final doctorDocument =
      await firestore.collection('doctors').doc(widget.otherUserId).get();
      if (doctorDocument.exists &&
          doctorDocument.data()!.containsKey('name')) {
        otherUserName = doctorDocument.data()!['name'];
      }
    }

    return otherUserName;
  }

  // Usage in your code
  String otherUserName = '';

  @override
  void initState() {
    super.initState();
    getOtherUserName().then((value) {
      setState(() {
        otherUserName = value;
      });
    });

    _chatService = ChatService();
    _messagesStream =
        _chatService.getMessages(widget.userId, widget.otherUserId);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String message, String receiverId) {
    _chatService.sendMessage(message, receiverId).then((_) {
      _messageController.clear();
    }).catchError((error) {
      print('Failed to send message: $error');
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6527BE),
        title: Text('$otherUserName'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _messagesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff6527BE),
                        backgroundColor: Color(0xffB28CFF),
                      ),
                    );
                  }

                  final messages = snapshot.data!.docs;

                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });

                  return ListView.builder(

                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message =
                      messages[index].data() as Map<String, dynamic>?;

                      if (message == null) {
                        return SizedBox.shrink();
                      }

                      final String? senderId = message['senderId'] as String?;
                      final String? messageText =
                      message['message'] as String?;
                      final Timestamp? timestamp =
                      message['time'] as Timestamp?;




                      final bool isCurrentUser = senderId == widget.userId;

                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: isCurrentUser ? Color(0xffB28CFF) : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                messageText ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                timestamp != null
                                    ? '${DateFormat('dd MMM hh:mm').format(timestamp.toDate())}'
                                    : '',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTap: () {
                        WidgetsBinding.instance?.addPostFrameCallback((_) {
                          _scrollToBottom();
                        });
                      },
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final String message = _messageController.text.trim();
                      if (message.isNotEmpty) {
                        _sendMessage(message, widget.otherUserId);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
