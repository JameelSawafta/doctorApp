import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/repository/sql_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/AllDoctors/alldoctors.dart';
import 'views/Auth/login.dart';
import 'views/Auth/signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'views/Home/homePage.dart';
import 'views/AllDoctors/doctorsEachCategory.dart';
import 'views/core/core.dart';
import 'views/doctor/doctorHome.dart';
import 'views/doctor/doctorsCore.dart';


//import 'middleware/auth_middleware.dart';





SharedPreferences? prefs;

void main() async {


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();



  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  User? user;




  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

  }







  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context , child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Doctor App',
            initialRoute:  user == null
                ? '/'
                : '/core',

            getPages: [
              GetPage(
                name: '/',
                page: () => Login(),
                //middlewares: [AuthMiddleware(),],
              ),
              GetPage(
                name: '/signup',
                page: () => Signup(),
              ),
              GetPage(
                name: '/core',
                page: () => Core(initindex: 0,),
              ),
              GetPage(
                name: '/home',
                page: () => HomePage(),
              ),
              GetPage(
                name: '/allDoctors',
                page: () => AllDoctors(),
              ),
              GetPage(
                name: '/doctorsEachCategory',
                page: () => DoctorsEachCategory(),
              ),
              GetPage(
                name: '/doctorHome',
                page: () => DoctorHome(),
              ),
              GetPage(
                name: '/doctorCore',
                page: () => DoctorsCore(initindex: 0,),
              ),






            ],
          );
        }
    );
  }
}