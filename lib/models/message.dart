import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp time;


  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.time,
  });

  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(
      senderId: data['senderId'],
      senderEmail: data['senderEmail'],
      receiverId: data['receiverId'],
      message: data['message'],
      time: data['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'time': time,
    };
  }



}