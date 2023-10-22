import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:screens/Main/NavigationScreen/editac/Editac.dart';
import 'package:screens/Main/SideScreen/OnboardingScreen/OnboadrintCont.dart';

class IntroScreen extends StatelessWidget{
   IntroScreen({super.key});
  var _controller  = Get.put(IntroScreenController());
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: Lottie.asset('assets/IntroScreen.json'), nextScreen:EditAc(), duration: 10  );
  }
}