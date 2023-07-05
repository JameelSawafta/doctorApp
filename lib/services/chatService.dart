import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String message, String receiverId) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp currentTime = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      time: currentTime,
    );

    List<String> users = [currentUserId, receiverId];
    users.sort();

    String chatRoomId = users.join('_');

    await _firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    // Create or update chatroom document
    await _firestore.collection('chatrooms').doc(chatRoomId).set({
      'receiverId': receiverId,
      "senderId": currentUserId,
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> users = [userId, otherUserId];
    users.sort();

    String chatRoomId = users.join('_');

    return _firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots();
  }

  Future<List<String>> getAllChatsForCurrentUser() async {
    final String currentUserId = _auth.currentUser!.uid;


    List<String> chatIds = [];
    QuerySnapshot querySnapshot = await _firestore
        .collection('chatrooms')
        .where('senderId', isEqualTo: currentUserId)
        .get();

    querySnapshot.docs.forEach((doc) {
      String chatId = doc.id;
      chatIds.add(chatId);
    });

    querySnapshot = await _firestore
        .collection('chatrooms')
        .where('receiverId', isEqualTo: currentUserId)
        .get();

    querySnapshot.docs.forEach((doc) {
      String chatId = doc.id;
      if (!chatIds.contains(chatId)) {
        chatIds.add(chatId);
      }
    });

    print(chatIds);
    return chatIds;
  }


  Future<Map<String, dynamic>> getOtherUserData(String otherUserId) async {
    Map<String, dynamic> otherUserData = {};

    // Check the "users" collection
    final userDocument =
    await _firestore.collection('users').doc(otherUserId).get();
    if (userDocument.exists) {
      otherUserData = userDocument.data()!;
    }

    // Check the "doctors" collection if the name is not found in "users"
    if (otherUserData.isEmpty) {
      final doctorDocument =
      await _firestore.collection('doctors').doc(otherUserId).get();
      if (doctorDocument.exists) {
        otherUserData = doctorDocument.data()!;
      }
    }

    return otherUserData;
  }

  getCurrentUserId() {
    return _auth.currentUser!.uid;
  }
}
