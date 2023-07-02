import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../repository/sql_helper.dart';
import '../AllDoctors/doctorsEachCategory.dart';
import '../doctor/appointment.dart';


class HomePage extends StatefulWidget {
  var quote;
  var userData;
  var allDoctors;

   HomePage({Key? key, this.quote, this.userData, this.allDoctors}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  var serviceCategoriesMap = {"doctor.png":"General Physician","hart.png":"Cardiologist","brain.png":"Neurologist","dentist.png":"Dentist","bone.png":"Orthopedic"};





  // {  address: Instance of 'GeoPoint',8}

  void addDataToFirestore() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference doctorRef = firestore.collection('doctors').doc("8zeTl7KFLadCwoC2Tnhq5ftC9b13");

    Map<String, dynamic> data = {
      "date": {
        "1": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"],
        "2": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"],
        "3": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"],
        "4": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"],
        "5": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"]
      },
      "cost": 200,
      "jobTitle": "Cardiologist",
      "name": "Momen Sawafta",
      "email": "momen.doctor1745@gmail.com",
      "rating": 5,
      "photo": "https://firebasestorage.googleapis.com/v0/b/doctor-f93b6.appspot.com/o/Ezz.jpg?alt=media&token=d80f2d08-7649-4520-8da7-9bd0aab4c793",
      "yearsExperience": 5,
      'uid': "8zeTl7KFLadCwoC2Tnhq5ftC9b13",
    };

    doctorRef.set(data)
        .then((value) {
      print("Data added to Firestore successfully!");
    })
        .catchError((error) {
      print("Failed to add data to Firestore: $error");
    });
  }

  void getDataFromFirestore() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference doctorRef = firestore.collection('doctors').doc("cJ94d0ayS8c7xjTeFFl8WCQ5WJ63");

    doctorRef.get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        print(documentSnapshot.data());
      }
    });
  }




  @override
  void initState() {
    // addDataToFirestore();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h,),
              Text("HI, ${widget.userData?['name'].toString().split(" ")[0] ?? ""} 👋",style: TextStyle(fontSize: 14),),
              SizedBox(height: 10.h,),
              Text("Keep taking",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              Text("care of your health",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.h,),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                color: Color(0xffB28CFF),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Quote of the day",style: TextStyle(fontSize: 14),),
                      SizedBox(height: 10.h,),
                      Text(widget.quote?[0]['quote'] ?? "Loading...",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10.h,),
                      Text(widget.quote?[0]['author'] ?? "",style: TextStyle(fontSize: 12),),

                    ],
                  ),
                )
              ),
              SizedBox(height: 20.h,),
              Text("Service Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.h,),
              Container(
                height: 120.h,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: serviceCategoriesMap.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        var doctors = widget.allDoctors?.where((element) => element['jobTitle'].replaceAll(' ', '') == serviceCategoriesMap.values.elementAt(index).replaceAll(' ', '')).toList();
                        Get.to(DoctorsEachCategory(doctorsCategory: doctors,userData: widget.userData,));
                        },
                      child: Container(
                        width: 110.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff758aff).withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("images/serviceCategories/${serviceCategoriesMap.keys.elementAt(index)}",height: 40,width: 40,),
                              SizedBox(height: 12.h,),
                              Text(serviceCategoriesMap.values.elementAt(index),style: TextStyle(fontSize: 17,color: Color(0xff79859D)),textAlign: TextAlign.center,),
                            ],
                          ),
                        )
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h,),
              Text("Popular Doctors",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.h,),
              // show popular doctors
              Container(
                height: 190.h,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.allDoctors?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    double rating = widget.allDoctors?[index]['rating']?.toDouble() ?? 0;
                    if (rating >= 4.5) {
                      return InkWell(
                        onTap: (){
                          Get.to(Appointment(doctorData: widget.allDoctors?[index],userData: widget.userData,));
                        },
                        child: Container(
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff758aff).withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    widget.allDoctors?[index]['photo'] ??
                                        "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                                  ),
                                ),
                                SizedBox(height: 12.h,),
                                Text(
                                  widget.allDoctors?[index]['name'] ?? "",
                                  style: TextStyle(fontSize: 17, color: Color(0xff79859D)),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 5.h,),
                                Text(
                                  widget.allDoctors?[index]['jobTitle'] ?? "",
                                  style: TextStyle(fontSize: 14, color: Color(0xff79859D)),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 5.h,),
                                RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  ignoreGestures: true,
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),

              ),
            ],
          ),
        ),
      )
    );
  }
}


