import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../chat/chatPage.dart';

class Appointment extends StatefulWidget {
  var doctorData;
  var userData;
  Appointment({Key? key, this.doctorData, this.userData}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  var selectedDate = DateTime.now();
  int numOfTheDay = 1;

  TextEditingController noteController = TextEditingController();


  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("doctors")
        .doc(widget.doctorData.id)
        .get()
        .then((docSnapshot) {
      setState(() {
        widget.doctorData = docSnapshot;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Appointment",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff263257),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff263257),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat,
              color: Color(0xff263257),
            ),
            onPressed: () {

              var currentUserId = FirebaseAuth.instance.currentUser!.uid;

              Get.to(
                  ChatPage(userId: currentUserId,otherUserId: widget.doctorData['uid'],)
              );

            },
          ),],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Container(
                height: 93.h,
                width: 89.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(widget.doctorData['photo']),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Dr. ${widget.doctorData['name']}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff263257),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "${widget.doctorData['jobTitle']}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff263257),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                height: 106.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffB28CFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 104.w,
                      height: 76.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.doctorData['cost']}\$",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffB28CFF),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Cost",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8A96BC),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100.w,
                      height: 76.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.doctorData['yearsExperience']}+",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9DEAC0),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Exp. years",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8A96BC),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 104.w,
                      height: 76.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "350",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffFF9A9A),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Reviews",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8A96BC),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              //About Doctor
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "About Doctor",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff263257),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                "Dr. ${widget.doctorData['name']} is the top most Cardiologist specialist in Nanyang Hospotalat London. She is available for private consultation.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8A96BC),
                ),
              ),
              SizedBox(height: 20.h),
              //Available Time
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Schedules",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff263257),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // use date picker timeline
              DatePicker(
                DateTime.now(),
                daysCount: 5,
                initialSelectedDate: DateTime.now(),
                selectionColor: Color(0xffB28CFF),
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    selectedDate = date;
                    final now = DateTime.now();
                    final today = DateTime(now.year, now.month, now.day);
                    final difference = selectedDate.difference(today).inDays;

                    if (selectedDate == today) {
                      numOfTheDay = 1;
                    } else if (difference >= 1 && difference <= 4) {
                      numOfTheDay = difference + 1;
                    }
                    print(numOfTheDay);
                  });
                },
              ),
              SizedBox(height: 20.h),
              // visit hour
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Visit Hour",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff263257),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                height: 200.h,
                child: GridView.builder(
                  itemCount: widget.doctorData['date']["$numOfTheDay"].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffB28CFF),
                    ),
                    child: InkWell(
                      onTap: () {
                        var selectedTime = widget.doctorData['date']["$numOfTheDay"][index];

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Are you sure you want to book this time?'),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: noteController,
                                    decoration: InputDecoration(
                                      labelText: 'Note',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel', style: TextStyle(color: Color(0xffFF9A9A))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Confirm', style: TextStyle(color: Color(0xff9DEAC0))),
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                    String note = noteController.text;

                                    var updatedDateMap = Map<String, dynamic>.from(widget.doctorData['date']);
                                    updatedDateMap["$numOfTheDay"] = FieldValue.arrayRemove([selectedTime]);

                                    var updatedTimeList = List<String>.from(widget.doctorData['date']["$numOfTheDay"]);
                                    updatedTimeList.remove(selectedTime);

                                    updatedDateMap["$numOfTheDay"] = updatedTimeList;



                                    FirebaseFirestore.instance
                                        .collection("doctors")
                                        .doc(widget.doctorData['uid'])
                                        .update({
                                      "date": updatedDateMap,
                                    });

                                    FirebaseFirestore.instance
                                        .collection("doctors")
                                        .doc(widget.doctorData.id)
                                        .get()
                                        .then((docSnapshot) {
                                      setState(() {
                                        widget.doctorData = docSnapshot;
                                      });
                                    });
                                    // Add the selected time to show them in the appointment doctor screen
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .collection("appointments")
                                        .add({
                                      "doctorName": widget.doctorData['name'],
                                      "doctorSpeciality": widget.doctorData['jobTitle'],
                                      "doctorUid": widget.doctorData['uid'],
                                      "date": selectedDate,
                                      "time": selectedTime,
                                      "note": note, // Include the note in the appointment data
                                    });
                                    // add the selected time to show them in the appointment user screen
                                    FirebaseFirestore.instance
                                        .collection("doctors")
                                        .doc(widget.doctorData.id)
                                        .collection("appointments")
                                        .add({
                                      "patientName": widget.userData['name'],
                                      "dateOfBirth": widget.userData['date'],
                                      "phoneNumber": widget.userData['phone'],
                                      "patientUid": FirebaseAuth.instance.currentUser!.uid,
                                      "date": selectedDate,
                                      "time": selectedTime,
                                      "note": note,

                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },


                      child: Center(
                        child: Text(
                          "${widget.doctorData['date']["$numOfTheDay"][index].split(" ")[0]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
