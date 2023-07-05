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
import 'MachineLearning/cardiovascularDisease.dart';
import 'doctorHome.dart';

class DoctorsCore extends StatefulWidget {
  var initindex;

  DoctorsCore({Key? key, this.initindex}) : super(key: key);

  @override
  State<DoctorsCore> createState() => _DoctorsCoreState();
}

class _DoctorsCoreState extends State<DoctorsCore> {



  var user = FirebaseAuth.instance.currentUser;

  var doctorData;
  var doctorRef = FirebaseFirestore.instance.collection('doctors');

  getDoctorData() async {
    await doctorRef.doc(user!.uid).get().then((value) {
      doctorData = value.data();
    });
    setState(() {

    });
  }

  Future<List<DocumentSnapshot>> _fetchAppointments() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("doctors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("appointments")
        .get();
    return querySnapshot.docs;
  }

  List<DocumentSnapshot> doctorAppointments = [];




  var pages = [
    DoctorHome( doctorAppointments: [],),
    ChatsPage(),
    CardiovascularDisease(),
    Profile()
  ];

  @override
  void initState() {
    super.initState();

    getDoctorData().then((_) {
      _fetchAppointments().then((value) {
        doctorAppointments = value;
        setState(() {
          pages = [
            DoctorHome(doctorData: doctorData, doctorAppointments: doctorAppointments,),
            ChatsPage(),
            CardiovascularDisease(),
            Profile(userData: doctorData)
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
          Icon(Icons.medical_services),
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
