import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:screens/Main/Auth/Authcont.dart';
import 'package:screens/Main/LoginScreen/Signup/signUps.dart';
import 'package:screens/main.dart';

class SignInController extends GetxController {
  var autCont = Get.find<AuthController>();
  RxBool passhidden = true.obs;
  var _firebaseAuth = FirebaseAuth.instance;
  TextEditingController mailTController = TextEditingController();
  TextEditingController passTController = TextEditingController();
  changevisibility() {
    passhidden.value = !passhidden.value;
  }

  loginaccount()async{
    try{
      var ac = await _firebaseAuth.signInWithEmailAndPassword(email: mailTController.text.trim(), password:passTController.text.trim()).then((value) {
        Cur_user_id = value.user?.displayName;
      });
    mailTController.clear();
    passTController.clear();
    }
    catch(e){
      Get.showSnackbar(GetSnackBar(title: "Error", message: "${e.toString()}", duration: Duration(seconds: 2),));
    }
  }



  gotopolicy() => (){};
  gotosignup (){
    autCont.changeScreen("SignUp");
    
  }
}
