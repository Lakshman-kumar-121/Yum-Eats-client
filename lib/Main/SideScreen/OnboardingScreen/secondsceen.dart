import 'package:flutter/material.dart';
import 'package:screens/Main/LoginScreen/SignIn/reset.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

class Secondscreem extends StatelessWidget {
  const Secondscreem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,30, 177, 145),
      body: Column(
        children: [
          SizedBox(height: 80,),
          
         
          Container(
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10) ,),margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10 ,vertical: 10),
            
            child: Image.network('https://img.freepik.com/free-vector/watercolor-japan-food-illustration_23-2149284531.jpg' ,width: 200,height: 200,),
          ), SizedBox(height: 70,),
          Text("Yum Eats" , style: TextStyle(fontSize: 45,color: Colors.white.withOpacity(.8) , fontWeight: FontWeight.w700),),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Text("Embark on a flavorful adventure with YumEats. Discover a diverse selection of delicious cuisines, tantalizing specials, and personalized recommendations. Experience culinary delight at your fingertips." , style: TextStyle(fontSize: 15,color: Colors.white.withOpacity(.8) , fontWeight: FontWeight.w400),textAlign: TextAlign.center,),),
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