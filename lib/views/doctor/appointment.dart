import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:DoctorApp/keys/keys.dart';


import '../chat/chatPage.dart';

class Appointment extends StatefulWidget {
  var doctorData;
  var userData;
  Appointment({Key? key, this.doctorData, this.userData}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {


  final keys = Keys();
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
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: 93,
                width: 89,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(widget.doctorData['photo']),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Dr. ${widget.doctorData['name']}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff263257),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${widget.doctorData['jobTitle']}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff263257),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 106,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffB28CFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 104,
                      height: 76,
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
                          SizedBox(height: 5),
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
                      width: 100,
                      height: 76,
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
                          SizedBox(height: 5),
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
                      width: 104,
                      height: 76,
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
                          SizedBox(height: 5),
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
              SizedBox(height: 20),
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
              SizedBox(height: 10),
              Text(
                "Dr. ${widget.doctorData['name']} He is one of the best ${widget.doctorData['jobTitle']}. He is available for private consultation.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8A96BC),
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 10),
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
              SizedBox(height: 20),
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
              SizedBox(height: 10),
              Container(
                height: 200,
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
                                    noteController.clear();
                                  },
                                ),
                                TextButton(
                                  child: Text('Confirm', style: TextStyle(color: Color(0xff9DEAC0))),
                                  onPressed: () async {
                                    Navigator.of(context).pop();

                                    String note = noteController.text;
                                    noteController.clear();

                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                    PaypalCheckout(
                                      sandboxMode: true,
                                      clientId: keys.paypalClientId,
                                      secretKey: keys.paypalsecretKey,
                                      returnURL: "success.snippetcoder.com",
                                      cancelURL: "cancel.snippetcoder.com",
                                      transactions:[
                                        {
                                          "amount": {
                                            "total": '${widget.doctorData['cost']}',
                                            "currency": "USD",
                                            "details": {
                                              "subtotal": '${widget.doctorData['cost']}',
                                              "shipping": '0',
                                              "shipping_discount": 0
                                            }
                                          },
                                          "description": "The payment transaction description.",
                                          "item_list": {
                                            "items": [
                                              {
                                                "name": "Doctor Appointment for Dr. ${widget.doctorData['name']}",
                                                "quantity": 1,
                                                "price": '${widget.doctorData['cost']}',
                                                "currency": "USD"
                                              },
                                            ],
                                          }
                                        }
                                      ],
                                      note: "PAYMENT_NOTE",
                                      onSuccess: (Map params) async {

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


                                        print("onSuccess: $params");
                                      },
                                      onError: (error) {
                                        print("onError: $error");
                                        Navigator.pop(context);
                                      },
                                      onCancel: () {
                                        print('cancelled:');
                                      },
                                    ),
                                    ));

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
