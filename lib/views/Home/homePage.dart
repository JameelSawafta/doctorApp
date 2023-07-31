import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';


import '../AllDoctors/doctorsEachCategory.dart';
import '../doctor/appointment.dart';


class HomePage extends StatefulWidget {
  var quote;
  var userData;
  var allDoctors;
  var animationTarget;

   HomePage({Key? key, this.quote, this.userData, this.allDoctors, this.animationTarget}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  var serviceCategoriesMap = {"doctor.png":"General Physician","hart.png":"Cardiologist","brain.png":"Neurologist","dentist.png":"Dentist","bone.png":"Orthopedic"};




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
              SizedBox(height: 30,),
              Text("HI, ${widget.userData?['name'].toString().split(" ")[0] ?? ""} 👋",style: TextStyle(fontSize: 14),),
              SizedBox(height: 10,),
              if (widget.animationTarget == 1)
              Text("Keep taking",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),).animate()
                  .then(delay: 200.ms)
                  .slideX(begin: -1.0,duration: 800.ms,curve: Curves.easeOut),
              if (widget.animationTarget == 0)
                Text("Keep taking",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              if (widget.animationTarget == 1)
              Text("care of your health",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),).animate()
                  .then(delay: 200.ms)
                  .slideX(begin: -1.0,duration: 800.ms,curve: Curves.easeOut),
              if (widget.animationTarget == 0)
                Text("care of your health",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              if (widget.animationTarget == 1)
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
                      SizedBox(height: 10,),
                      Text(widget.quote?[0]['quote'] ?? "Loading...",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text(widget.quote?[0]['author'] ?? "",style: TextStyle(fontSize: 12),),

                    ],
                  ),
                )
              ).animate()
                  .then(delay: 200.ms)
                  .slideX(begin: 101,end: 0,duration: 1000.ms,curve: Curves.easeOut),
              if (widget.animationTarget == 0)
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
                          SizedBox(height: 10,),
                          Text(widget.quote?[0]['quote'] ?? "Loading...",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text(widget.quote?[0]['author'] ?? "",style: TextStyle(fontSize: 12),),

                        ],
                      ),
                    )
                ),
              SizedBox(height: 20,),
              if (widget.animationTarget == 1)
              Text("Service Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),).animate()
                  .then(delay: 200.ms)
                  .fade(duration: 800.ms,curve: Curves.easeOut),
              if (widget.animationTarget == 0)
                Text("Service Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Container(
                height: 120,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: serviceCategoriesMap.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    if (widget.animationTarget == 1)
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: (){
                          var doctors = widget.allDoctors?.where((element) => element['jobTitle'].replaceAll(' ', '') == serviceCategoriesMap.values.elementAt(index).replaceAll(' ', '')).toList();
                          Get.to(DoctorsEachCategory(doctorsCategory: doctors,userData: widget.userData,));
                          },
                        child: Container(
                          width: 120,
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
                                SizedBox(height: 12,),
                                Text(serviceCategoriesMap.values.elementAt(index),style: TextStyle(fontSize: 17,color: Color(0xff79859D)),textAlign: TextAlign.center,),
                              ],
                            ),
                          )
                        ),
                      ),
                    ).animate()
                        .then(delay: 200.ms)
                        .fade(duration: 1000.ms,curve: Curves.easeOut)
                        .slideY(begin: -1.0,duration: 800.ms,curve: Curves.easeOut);
                    if (widget.animationTarget == 0)
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: (){
                            var doctors = widget.allDoctors?.where((element) => element['jobTitle'].replaceAll(' ', '') == serviceCategoriesMap.values.elementAt(index).replaceAll(' ', '')).toList();
                            Get.to(DoctorsEachCategory(doctorsCategory: doctors,userData: widget.userData,));
                          },
                          child: Container(
                              width: 120,
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
                                    SizedBox(height: 12,),
                                    Text(serviceCategoriesMap.values.elementAt(index),style: TextStyle(fontSize: 17,color: Color(0xff79859D)),textAlign: TextAlign.center,),
                                  ],
                                ),
                              )
                          ),
                        ),
                      );
                  },
                ),
              ),
              SizedBox(height: 20,),
              if (widget.animationTarget == 1)
              Text("Popular Doctors",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),).animate()
                    .then(delay: 200.ms)
                    .fade(duration: 800.ms,curve: Curves.easeOut),
              if (widget.animationTarget == 0)
                Text("Popular Doctors",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              // show popular doctors
              Container(
                height: 190,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.allDoctors?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    double rating = widget.allDoctors?[index]['rating']?.toDouble() ?? 0;
                    if (widget.animationTarget == 1){
                    if (rating >= 4.5) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: (){
                            Get.to(Appointment(doctorData: widget.allDoctors?[index],userData: widget.userData,));
                          },
                          child: Container(
                            width: 200,
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
                                    backgroundImage: widget.allDoctors?[index]['photo'] == null
                                        ? AssetImage('images/person.png')
                                        : Image.network(
                                      widget.allDoctors?[index]['photo'],
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Image.asset('images/person.png', width: 70, height: 70);
                                      },
                                      errorBuilder: (context, error, stackTrace) =>
                                          Image.asset('images/person.png', width: 70, height: 70),
                                    ).image,
                                  ),

                                  SizedBox(height: 12,),
                                  Text(
                                    widget.allDoctors?[index]['name'] ?? "",
                                    style: TextStyle(fontSize: 17, color: Color(0xff79859D)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    widget.allDoctors?[index]['jobTitle'] ?? "",
                                    style: TextStyle(fontSize: 14, color: Color(0xff79859D)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 5,),
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
                            ).animate()
                                .then(delay: 200.ms)
                                .fade(duration: 1000.ms,curve: Curves.easeOut)
                                .slideY(begin: 101,duration: 800.ms,curve: Curves.easeOut),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                    }
                    if (widget.animationTarget == 0){
                      if (rating >= 4.5) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: InkWell(
                            onTap: (){
                              Get.to(Appointment(doctorData: widget.allDoctors?[index],userData: widget.userData,));
                            },
                            child: Container(
                              width: 200,
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
                                      backgroundImage: widget.allDoctors?[index]['photo'] == null
                                          ? AssetImage('images/person.png')
                                          : Image.network(
                                        widget.allDoctors?[index]['photo'],
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Image.asset('images/person.png', width: 70, height: 70);
                                        },
                                        errorBuilder: (context, error, stackTrace) =>
                                            Image.asset('images/person.png', width: 70, height: 70),
                                      ).image,
                                    ),




                                    SizedBox(height: 12,),
                                    Text(
                                      widget.allDoctors?[index]['name'] ?? "",
                                      style: TextStyle(fontSize: 17, color: Color(0xff79859D)),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      widget.allDoctors?[index]['jobTitle'] ?? "",
                                      style: TextStyle(fontSize: 14, color: Color(0xff79859D)),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5,),
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
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
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


