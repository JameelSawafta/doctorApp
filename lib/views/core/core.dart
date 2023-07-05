import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import '../AllDoctors/alldoctors.dart';
import '../Home/homePage.dart';
import '../chat/chatPage.dart';
import '../chat/chatsPage.dart';
import '../profile/profile.dart';
import 'waitingPage.dart';

class Core extends StatefulWidget {
  var initindex;

  Core({Key? key, this.initindex}) : super(key: key);

  @override
  State<Core> createState() => _CoreState();
}

class _CoreState extends State<Core> {


  var quote ;

  Future<void> fetchQuotes() async {

    // [{"quote": "It's wonderful that so many people want to contribute to fighting aids or malaria. But, if somebody isn't paying attention to the overall health system in the country, a whole lot of money can be wasted.", "author": "Paul Wolfowitz", "category": "health"}]
    final category = 'health';
    final apiURL = 'https://api.api-ninjas.com/v1/quotes?category=$category';
    final apiKey = 'avqOH0vijCMMNXFnFpoL4Q==W6d7wgp1yriyBSdz';

    final response = await http.get(
      Uri.parse(apiURL),
      headers: {'X-Api-Key': apiKey},
    );

    if (response.statusCode == 200) {
      setState(() {
        quote = json.decode(response.body);
      });
      //print(response.body);
    } else {
      print('Error: ${response.statusCode} ${response.body}');
    }
  }




  var user = FirebaseAuth.instance.currentUser;



  Map<String,dynamic>? userData;

  getUserData() async {
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then((value) {
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










  var pages = <Widget>[
    WaitingPage(),
    WaitingPage(),
    WaitingPage(),
    WaitingPage(),
  ];

  @override
  void initState() {
    super.initState();
    fetchQuotes().then((_) {
      getUserData().then((_) {
        if (userData == null) {
          Get.offAllNamed('/doctorCore');
        } else {
          getAllDoctors().then((_) {
            setState(() {
              pages = [
                HomePage(quote: quote, userData: userData, allDoctors: allDoctors),
                AllDoctors(allDoctors: allDoctors, userData: userData),
                ChatsPage(),
                Profile(userData: userData)
              ];
            });
          });
        }
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
          Icon(Icons.home),
          Icon(Icons.group_outlined),
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
