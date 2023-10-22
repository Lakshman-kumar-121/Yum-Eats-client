import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:screens/Main/Auth/Authcont.dart';
import 'package:screens/Main/NavigationScreen/editac/Editac.dart';
import 'package:screens/Main/AccountScreens/newaccount/newaccount.dart';
import 'package:screens/Main/LoginScreen/Signup/Otp.dart';
import 'package:screens/Main/LoginScreen/SignIn/signin.dart';
import 'package:screens/main.dart';

class SignupContoller extends GetxController {
  var countrycode;
    var autCont = Get.find<AuthController>();
  var signup_name = TextEditingController();
  var signup_number = TextEditingController();
    var _firebaseAuth = FirebaseAuth.instance;
    var smsCode;
  var number;
  var verificatioId;
  RxInt stimer = 0.obs;

late Timer _timer;
resndCode()async{
  
  print('oyr');

  if(stimer.value<=0){ try{   
    
     await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+${countrycode} ${signup_number.text.trim()}',
      timeout: Duration.zero,
      verificationCompleted: (PhoneAuthCredential creential){},
     verificationFailed: (FirebaseAuthException e){}, 
     codeSent: (String verificationId, int? resendToken) {

     },
      codeAutoRetrievalTimeout: (String verificationId) {});}
  
  catch(e){
    Get.showSnackbar(GetSnackBar(title: "Error",
    message: "An error occured ${e.toString()}",
    ));
  }}
  
}
void startTimer() {
  print("loded");
  if(stimer.value <= 0){
    print("loded not bro");
     stimer.value = 60;
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
    (Timer timer) {
      if (stimer.value == 0) {
        
          timer.cancel();
      } else {
      stimer.value  -= 1;
      
      }
    },
    
  );}
}
resendCode(){
  if(stimer.value <= 0){

                      return Text("Resend code" , style: TextStyle(color: Colors.blueAccent , fontWeight: FontWeight.w500),);

}
                    return Text("Resend code" ,style: TextStyle(color: Colors.grey , fontWeight: FontWeight.w500));
                  }



  verifyPhoneNumner()async{
    try{    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+$countrycode ${signup_number.text.trim()}',
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential creential){},
     verificationFailed: (FirebaseAuthException e){}, 
     codeSent: (String verificationId, int? resendToken) {
      verificatioId = verificationId;
      
      startTimer();
      Get.to(OtpScreen());
     },
      codeAutoRetrievalTimeout: (String verificationId) {});}
  
  catch(e){
    Get.showSnackbar(GetSnackBar(title: "Error",
    message: "An error occured ${e.toString()}",
    ));
  }}


  
  verifyOtp()async{
    try{   
    var mailuid ;   
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificatioId, smsCode: smsCode);
    await _firebaseAuth.signInWithCredential(credential).then((value) async{
      mailuid = value.user?.uid ;
    await _firebaseAuth.currentUser?.delete();
    }
    );
    Get.off(NewAccount(number: "${countrycode} ${signup_number.text.trim()}" , uid: mailuid ,));
    }
    catch(e){
      Get.showSnackbar(GetSnackBar(title: "Error",
    message: "${e.toString()}",
    ));
    }
  }

  signup() {
    if (signup_number.text.trim().length >= countrycode.maxLength &&
        signup_name.text.trim().isNotEmpty) {
      print("another function");
      startTimer();
      Get.to(OtpScreen());
    } else {
      Get.snackbar("Incomplete fields", "Please fill all fields",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
    gotosignin() {
      autCont.changeScreen("SignIn");
  }

}