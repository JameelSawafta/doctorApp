import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../main.dart';
import 'Widgets/bottonlogsign.dart';
import 'Widgets/googleOrFacebook.dart';


class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  var _email ='';
  var _password ='';

  TextEditingController _emailController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 110,),
              Container(
                height: 88,
                width: 284,
                child: Column(
                  children: [
                    Center(
                        child: Text('Welcome back', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        )
                    ),
                    SizedBox(height: 8,),
                    Center(
                        child: Text('You can search for a doctor, book an appointment with a doctor, and find comprehensive medical information.',textAlign: TextAlign.center, style: TextStyle(fontSize: 14,color: Color(0xff677294),
                        )
                        )
                    ),
                  ],
                ),
              ),
              Container(
                height: 260,
                width: 335,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    SizedBox(height: 20,),
                    Form(
                      key: _formKey,
                        child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress, // keyboard type

                          cursorColor: Color(0xff263257) ,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Email",
                            labelStyle: TextStyle(color: Color(0xff677294), fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Color(0xff263257).withOpacity(0.1), width: 1.0),
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

                          cursorColor: Color(0xff263257) ,

                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Password",
                            labelStyle: TextStyle(color: Color(0xff677294), fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff263257).withOpacity(0.1), width: 1.0),
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
                  ],
                )
              ),
              SizedBox(height: 20,),
              BottonLogSign(
                  text: 'Login',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(email: _email, password: _password)
                      .then((value) {
                    // Check if user is a doctor
                    FirebaseFirestore.instance
                        .collection('doctors')
                        .where('email', isEqualTo: _email)
                        .get()
                        .then((snapshot) {
                      if (snapshot.size > 0) {
                        Get.offAllNamed('/doctorCore'); // Navigate to doctors core
                      } else {
                        Get.offAllNamed('/core'); // Navigate to core
                      }
                    }).catchError((e) {
                      print(e);
                      Get.snackbar(
                          'Error retrieving user data', e.toString(),
                          backgroundColor: Colors.red, colorText: Colors.white);
                    });
                  }).catchError((e) {
                    print(e);
                    Get.snackbar('Error login account', e.toString(),
                        backgroundColor: Colors.red, colorText: Colors.white);
                  });
                },
              ),
              SizedBox(height: 20,),
              Container(
                height: 157,
                width: 196,
                child: Column(
                  children: [
                    Center(
                        child: InkWell(
                          child: Text('Forgor password', style: TextStyle(fontSize: 14, color: Color(0xff263257), fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim()).then((value) {
                              Get.snackbar('Reset password', 'Please check your email', backgroundColor: Colors.green, colorText: Colors.white);
                            }).catchError((e) {
                              print(e);
                              Get.snackbar('Error reset password', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
                            });

                          },
                        )
                    ),
                    SizedBox(height: 123,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?', style: TextStyle(fontSize: 14, color: Color(0xff677294), fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5,),
                        InkWell(
                          child: Text('Join us', style: TextStyle(fontSize: 14, color: Color(0xff263257), fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Get.offAllNamed('/signup');
                          },
                        ),
                      ],
                   )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}