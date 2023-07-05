
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DoctorHome extends StatefulWidget {

  var doctorData;
  List<DocumentSnapshot> doctorAppointments;
  DoctorHome({Key? key, this.doctorData ,required this.doctorAppointments }) : super(key: key);

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


  @override
  void initState() {
    _fetchAppointments().then((value) {
      widget.doctorAppointments = value;
      setState(() {});
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff6527BE),
        title: Text("Appointments"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              // Display the appointments as a list
              if (widget.doctorAppointments.isEmpty) ...[
                Center(
                  child: Text("No Appointments"),
                ),
              ] else ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.doctorAppointments.length,
                  itemBuilder: (context, index) {
                    var appointment = widget.doctorAppointments[index];
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
