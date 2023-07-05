import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../main.dart';
import 'Widgets/bottonlogsign.dart';
import 'Widgets/googleOrFacebook.dart';
import 'package:intl/intl.dart';



class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  var _name ='';
  var _phone ='';
  var _email ='';
  var _password ='';
  String? _selectedDate;

    void _showDatePicker() {
      showDatePicker(

        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          _selectedDate = formattedDate;
        });
      });
    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Container(
                height: 560,
                width: 335,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text('Join us to start searching', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        )
                    ),
                    SizedBox(height: 8,),
                    Center(
                        child: Text('You can search for a doctor, book an appointment with a doctor, and find comprehensive medical information.',textAlign: TextAlign.center, style: TextStyle(fontSize: 14,color: Color(0xff677294),
                        )
                        )
                    ),
                    SizedBox(height: 20,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     GoogleOrFacebook(color: Color(0xff677294), text: 'Google', image: 'images/iconsForAuth/google.png', onPressed: () {
                    //       Get.toNamed('/');
                    //     },),
                    //     Spacer(),
                    //     GoogleOrFacebook(color: Color(0xff677294), text: 'Facebook', image: 'images/iconsForAuth/facebook.png', onPressed: () {
                    //       Get.toNamed('/');
                    //     },),
                    //   ],
                    // ),
                    // SizedBox(height: 20,),
                    Form(
                        key: _formKey,
                        child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.name, // keyboard type

                          cursorColor: Color(0xff7563F7) ,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Name",
                            labelStyle: TextStyle(color: Color(0xff677294), fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xff7563F7).withOpacity(0.1), width: 1.0),
                            ),

                          ),
                          onSaved: (value) {
                             _name = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          keyboardType: TextInputType.phone, // keyboard type

                          cursorColor: Color(0xff7563F7) ,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Phone Number",
                            labelStyle: TextStyle(color: Color(0xff677294), fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xff7563F7).withOpacity(0.1), width: 1.0),
                            ),

                          ),
                          onSaved: (value) {
                             _phone = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            else if (value.isPhoneNumber == false) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress, // keyboard type

                          cursorColor: Color(0xff7563F7) ,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Email",
                            labelStyle: TextStyle(color: Color(0xff677294), fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xff7563F7).withOpacity(0.1), width: 1.0),
                            ),

                          ),
                          onSaved: (value) {
                             _email = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            else if (value.isEmail == false) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20,),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword, // keyboard type
                          obscureText: _obscureText, // password

                          cursorColor: Color(0xff7563F7) ,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Password",
                            labelStyle: TextStyle(color: Color(0xff677294), fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff7563F7).withOpacity(0.1), width: 1.0),
                            ),

                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                                color: Color(0xff677294),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),

                          ),
                          onSaved: (value) {
                             _password = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            else if (value.length < 8 ) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                        ),
                      ],
                    )
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(335, 40),
                        ),
                        onPressed:(){
                          _showDatePicker();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate == null ? 'Date of birth' : _selectedDate.toString(),
                              style: TextStyle(
                                color: Color(0xff677294),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Color(0xff677294),
                            ),
                          ],
                        )
                    )
                  ],
                )
            ),
            SizedBox(height: 20,),
            BottonLogSign(
              text: 'Sign up',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
                if (_selectedDate == null) {
                  Get.snackbar('Error', 'Please pick a date', backgroundColor: Colors.red, colorText: Colors.white);
                  return;
                }
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email:  _email,
                    password: _password
                )
                    .then((value) {
                  print(value.user!.uid);
                  FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
                    'name': _name,
                    'phone': _phone,
                    'email': _email,
                    'uid': value.user!.uid,
                    'date': _selectedDate,
                    'doctor': false,
                  });
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  Get.offAllNamed('/core');
                })
                    .catchError((error) {
                  print(error);
                });
              },
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Have an account?', style: TextStyle(fontSize: 14, color: Color(0xff677294), fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5,),
                InkWell(
                  child: Text('Log in', style: TextStyle(fontSize: 14, color: Color(0xff7563F7), fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.offAllNamed('/');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}