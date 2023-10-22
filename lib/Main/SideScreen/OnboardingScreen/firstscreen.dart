import 'package:flutter/material.dart';
import 'package:screens/Main/LoginScreen/SignIn/reset.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

class StartSceen extends StatelessWidget {
  const StartSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,30, 177, 145),
      body: Column(
        children: [
          SizedBox(height: 80,),
          
         
          Container(
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20) ,),margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 10),
            
            child: Lottie.asset('assets/IntroScreen.json'),
          ), SizedBox(height: 70,),
          Text("Yum Eats" , style: TextStyle(fontSize: 45,color: Colors.white.withOpacity(.8) , fontWeight: FontWeight.w700),),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Text("Get started with YumEats and indulge in a delightful culinary journey. Explore a wide range of mouthwatering dishes, daily specials, and personalized recommendations. Order with ease and savor every bite." , style: TextStyle(fontSize: 15,color: Colors.white.withOpacity(.8) , fontWeight: FontWeight.w400),textAlign: TextAlign.center,),),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ElevatedButton(child: Text("Get Started" ,style: TextStyle(fontSize: 18 , color: Colors.black),) ,onPressed: (){},
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Colors.white
          ,minimumSize: Size(200 , 50)
        ),
        )),
    );
  }
}