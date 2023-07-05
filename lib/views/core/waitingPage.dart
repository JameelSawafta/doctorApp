import 'package:flutter/material.dart';

class WaitingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xff6527BE),
          backgroundColor: Color(0xffB28CFF),
        ),
      ),
    );
  }
}
