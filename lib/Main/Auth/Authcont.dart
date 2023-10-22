import 'package:get/get.dart';

class AuthController extends GetxController{
  RxString currentScreen = "SignIn".obs;

  changeScreen(screen){
    currentScreen.value = screen;
  }
}