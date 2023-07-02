import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../AllDoctors/alldoctors.dart';
import '../Home/homePage.dart';
import '../chat/chatPage.dart';
import '../chat/chatsPage.dart';
import '../profile/profile.dart';
import 'doctorChat.dart';
import 'doctorHome.dart';

class DoctorsCore extends StatefulWidget {
  var initindex;

  DoctorsCore({Key? key, this.initindex}) : super(key: key);

  @override
  State<DoctorsCore> createState() => _DoctorsCoreState();
}

class _DoctorsCoreState extends State<DoctorsCore> {



  var user = FirebaseAuth.instance.currentUser;
  Map<String,dynamic>? userData;

  var userref = FirebaseFirestore.instance.collection('users');

  getUserData() async {
    await userref.doc(user!.uid).get().then((value) {
      userData = value.data();
    });
    setState(() {

    });

    //print(userData);
  }

  var allDoctors;

  // get all doctors data
  getAllDoctors() async {
    await FirebaseFirestore.instance.collection('doctors').get().then((value) {
      allDoctors = value.docs;
    });
    setState(() {

    });
    // print(allDoctors[0].data());
  }

  // get all users data
  // getAllUsers() async {
  //   await  FirebaseFirestore.instance.collection('users').get().then((value) {
  //     value.docs.forEach((element) {
  //       print(element.data());
  //     });
  //   });
  // }









  var pages = [
    DoctorHome(),
    ChatsPage(),
    Profile()
  ];

  @override
  void initState() {
    super.initState();
      getUserData().then((_) {
        getAllDoctors().then((_) {
          setState(() {
            pages = [
              DoctorHome(),
              ChatsPage(),
              Profile()
            ];
          });
        });
      });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(

        index: widget.initindex,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,

        items: [

          Icon(Icons.calendar_today),
          Icon(Icons.chat),
          Icon(Icons.person),
        ],
        onTap: (index){
          setState(() {
            widget.initindex=index;
          });
        },
      ),
      body: pages[widget.initindex],
    );
  }
}
