import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleOrFacebook extends StatelessWidget {

  Color? _color;
  String? _text;
  String? _image;
  Function()? _onPressed;
  GoogleOrFacebook({required Color color, required String text, required String image, required Function()? onPressed}){
    _color = color;
    _text = text;
    _image = image;
    _onPressed = onPressed;
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onPressed!();
      },
      child: Container(
          width: 170.h,
          height: 54.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.1),
            ),
            color: Colors.white,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              Image.asset('$_image', width: 18.17.w, height: 18.17.h,),
              SizedBox(
                width: 20.w,
              ),
              Text('$_text', style: TextStyle(fontSize: 16, color: _color),),
            ],
          )
      ),
    );
  }
}