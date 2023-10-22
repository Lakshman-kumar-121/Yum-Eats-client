import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/Auth/Authcont.dart';
import 'package:screens/Main/LoginScreen/Signup/signUps.dart';
import 'package:screens/Main/LoginScreen/SignIn/signin.dart';

class FoodAuth extends StatelessWidget {
  FoodAuth({super.key});
  var authCont = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(authCont.currentScreen.value == "SignIn") return SignIn();
      return SignUp();
    },);
  }
}