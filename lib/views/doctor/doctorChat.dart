import 'package:flutter/material.dart';

class DoctorChat extends StatefulWidget {
  const DoctorChat({Key? key}) : super(key: key);

  @override
  State<DoctorChat> createState() => _DoctorChatState();
}

class _DoctorChatState extends State<DoctorChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: const Center(
        child: Text('Chat'),
      ),
    );
  }
}
