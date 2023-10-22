import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/Main/SideScreen/OnboardingScreen/IntroScreen.dart';
import 'package:screens/Main/SideScreen/OnboardingScreen/firstscreen.dart';
import 'package:screens/Main/SideScreen/OnboardingScreen/secondsceen.dart';
import 'package:screens/Realtimedb/demo.dart';
import 'package:screens/Sub/Navigation4/Navigation.dart';
import 'package:screens/Main/NavigationScreen/Allcategory/allcategory.dart';
import 'package:screens/Main/Auth/Auth.dart';
import 'package:screens/Main/AccountScreens/camera/camera.dart';

import 'package:screens/Main/NavigationScreen/cart/Mycart.dart';
import 'package:screens/Main/NavigationScreen/editac/Editac.dart';
import 'package:screens/Main/LoginScreen/Signup/Otp.dart';
import 'package:screens/screens/alert.dart';

import 'package:screens/Main/LoginScreen/Signup/signUps.dart';
import 'package:screens/Main/LoginScreen/SignIn/signin.dart';



late List<CameraDescription> cameras;

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Stripe.publishableKey = "pk_test_51MVyzFSH2NJoZfJJoPcrSYfaTqu6pW0jh4HF0vck2cjp9bmQquGxSlSCFxcmRn1UAerTzWMy2Vl6q7kIo3s0gt6u00Lj8SLPO3";
  // await Stripe.instance.applySettings();
  cameras = await availableCameras();
  runApp(const MyApp());
}

var Cur_user_id;
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:  StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            
              
            
            print("nav");
            return 
            // Termsandcond(); 
            // IntroScreen(); 
             Navigation();
          }
          // return   Secondscreem();
          // StartSceen();
           return FoodAuth();
          
        }
      ) //searchscreen(style: "North_indian"),
    );
  }
}