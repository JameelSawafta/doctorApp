import 'package:flutter/material.dart';

class BottonLogSign extends StatelessWidget {
  String? _text;
  Function()? _onPressed;
  BottonLogSign({ required String text, required Function()? onPressed}){
    _text = text;
    _onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 295,
      height: 54,
      child: ElevatedButton(
        onPressed: (){
          _onPressed!();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          primary: Color(0xffB28CFF),
        ),
        child: Text(
          "$_text",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
