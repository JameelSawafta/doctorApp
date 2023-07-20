
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../AllDoctors/alldoctors.dart';
import '../Home/homePage.dart';
import '../chat/chatsPage.dart';
import '../profile/profile.dart';

class Core extends StatefulWidget {
  var initindex;
  var quote;
  var userData;
  var allDoctors;

  Core({Key? key, this.initindex, this.quote, this.userData, this.allDoctors}) : super(key: key);

  @override
  State<Core> createState() => _CoreState();
}

class _CoreState extends State<Core> {


  var animationTarget = 1;





  @override
  Widget build(BuildContext context) {

    var pages = <Widget>[
      HomePage(quote: widget.quote, userData: widget.userData, allDoctors: widget.allDoctors, animationTarget: animationTarget,),
      AllDoctors(allDoctors: widget.allDoctors, userData: widget.userData),
      ChatsPage(),
      Profile(userData: widget.userData)
    ];


    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(

        index: widget.initindex,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,

        items: [
          Icon(Icons.home),
          Icon(Icons.group_outlined),
          Icon(Icons.chat),
          Icon(Icons.person),
        ],
        onTap: (index){
          setState(() {
            animationTarget = 0;
            widget.initindex=index;
          });
        },
      ),
      body: pages[widget.initindex],
    );
  }
}
