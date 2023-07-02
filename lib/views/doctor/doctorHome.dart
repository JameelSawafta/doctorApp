
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DoctorHome extends StatefulWidget {
  const DoctorHome({Key? key}) : super(key: key);

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {

  Future<List<DocumentSnapshot>> _fetchAppointments() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("doctors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("appointments")
        .get();
    return querySnapshot.docs;
  }

  List<DocumentSnapshot> doctorAppointments = [];




  @override
  void initState() {
    _fetchAppointments().then((appointments) {
      setState(() {
        doctorAppointments = appointments;
      });
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Rest of the code...
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          // Rest of the code...
          child: Column(
            children: [
              Text(
                "Appointments",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff263257),
                ),
              ),
              SizedBox(height: 10.h),
              // Display the appointments as a list
              if (doctorAppointments.isEmpty) ...[
                Center(
                  child: Text("No Appointments"),
                ),
              ] else ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: doctorAppointments.length,
                  itemBuilder: (context, index) {
                    var appointment = doctorAppointments[index];
                    var patientName = appointment['patientName'];
                    var dateOfBirth = appointment["dateOfBirth"];
                    var phoneNumber = appointment["phoneNumber"];
                    var appointmentDate = appointment['date'];
                    var appointmentTime = appointment['time'];
                    var note = appointment['note'];

                    return ListTile(
                      title: Text("Patient: $patientName"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date: ${appointmentDate.toDate().toString().substring(0, 10)}"),
                          Text("Time: $appointmentTime"),
                          Text("Note: $note"),
                          Text("Date of Birth: $dateOfBirth"),
                          Text("Phone Number: $phoneNumber"),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
