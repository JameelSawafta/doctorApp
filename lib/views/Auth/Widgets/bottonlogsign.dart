import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottonLogSign extends StatelessWidget {
  String? _text;
  Function()? _onPressed;
  BottonLogSign({ required String text, required Function()? onPressed}){
    _text = text;
    _onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xffB28CFF),
        ),
        width: 295,
        height: 54,
        child: Center(child: Text('$_text', style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),)),
      ),
      onTap: () {
        _onPressed!();
      },
    );
  }
}
