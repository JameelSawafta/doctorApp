import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  var userData;

  Profile({Key? key, this.userData}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  void updateDataToFirestore() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference doctorRef = firestore.collection('doctors').doc(FirebaseAuth.instance.currentUser!.uid);

    Map<String, dynamic> data = {
      "date": {
        "1": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"],
        "2": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"],
        "3": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"],
        "4": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"],
        "5": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"]
      },
    };

    doctorRef.update(data)
        .then((value) {
      deleteAllAppointments();
      print("Data added to Firestore successfully!");
    })
        .catchError((error) {
      print("Failed to add data to Firestore: $error");
    });
  }

  void deleteAllAppointments() {
    FirebaseFirestore.instance
        .collection("doctors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("appointments")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
      print("All appointments deleted successfully!");
    })
        .catchError((error) {
      print("Failed to delete appointments: $error");
    });
  }




  var day2 = [];
  var day3 = [];
  var day4 = [];
  var day5 = [];


  void nextDay() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference doctorRef =
    firestore.collection('doctors').doc(FirebaseAuth.instance.currentUser!.uid);

    doctorRef.get().then((value) {
      if (value.exists) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        if (data.containsKey('date')) {
          Map<String, dynamic> dateData = data['date'] as Map<String, dynamic>;
          day2 = List<String>.from(dateData['2']);
          day3 = List<String>.from(dateData['3']);
          day4 = List<String>.from(dateData['4']);
          day5 = List<String>.from(dateData['5']);

          Map<String, dynamic> updatedData = {
            "date": {
              "1": day2,
              "2": day3,
              "3": day4,
              "4": day5,
              "5": ["09:00 AM", "10:00 AM", "11:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM"]
            },
          };

          doctorRef
              .update(updatedData)
              .then((_) {
            print("Data updated in Firestore successfully!");
          })
              .catchError((error) {
            print("Failed to update data in Firestore: $error");
          });
        }
      }
    });

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xff6527BE),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAllNamed('/');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                  widget.userData['photo'] ??
                      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.userData['name'],
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.userData['email'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              if (widget.userData['jobTitle'] == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      widget.userData['phone'] ?? 'Not Available',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 8),
              if (widget.userData['jobTitle'] != null)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.grey[700],
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          widget.userData['jobTitle'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 8),
                        Text(
                          widget.userData['yearsExperience'].toString() +
                              ' Years Experience',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: Colors.grey[700],
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          widget.userData['cost'].toString() + ' \$',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff6527BE),
                        minimumSize: Size(200, 50),
                      ),
                      onPressed: () {
                        updateDataToFirestore();
                      } ,
                      child: Text('Update dates')
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff6527BE),
                          minimumSize: Size(200, 50),
                        ),
                        onPressed: () {
                          nextDay();
                        } ,
                        child: Text('Next day')
                    ),
                  ],
                ),
            ],

          ),
        ),
      ),
    );
  }
}
