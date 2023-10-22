import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AdditionalScreen/Orders/Order.dart';
import 'package:screens/Main/AdditionalScreen/Orders/red.dart';
import 'package:screens/Main/NavigationScreen/editac/Editac.dart';
import 'package:screens/Realtimedb/demo.dart';
import 'package:screens/main.dart';
import 'package:url_launcher/url_launcher.dart';

class profileController extends GetxController {
  bool hot = false;
  var usName;
  var _firebaseAuth = FirebaseAuth.instance;
  var _firebasefirestore = FirebaseFirestore.instance;
  var longitude;
  TextEditingController fdcont = TextEditingController();
  var latitude;
  var streak;
  getName(e) async {
    
    usName = e.data()?["Personaldata"]['Name'];
    var d = await _firebasefirestore
        .collection("accessory")
        .doc("Owner info")
        .get();
    latitude = d.data()?['Map']['Latitude'];
    longitude = d.data()?['Map']['Longitude'];


    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }
    print(e.data()?['streak']['Date']);
    var lastdate = DateTime.fromMillisecondsSinceEpoch(
        e.data()?['streak']['Date'].seconds * 1000);
    var count = e.data()?['streak']['count'];
    var curdate = DateTime.now();
    var diff = daysBetween(lastdate, curdate);
    if (diff < 2 && diff >= 0) {
      if(diff >= 1){
        hot = true;
      }
      streak = count;
    } else {
      e.data()?['streak']['count'] = 0;
      var s = e.data();
      s!['streak']['count'] = 0;
      print(s['streak']['count']);
      await _firebasefirestore.collection("users").doc("demo").set({
        "streak": {"Date": Timestamp.now(), "count": 0}
      }, SetOptions(merge: true));
      streak = 0;
    }
  }

  feedback()async{
    var s = {
        "Discription" : fdcont.text.trim(),
        "Time" : Timestamp.now() 
      
    };
    var d = await FirebaseFirestore.instance.collection("accessory").doc('feedback').set({Cur_user_id : s},SetOptions(merge: true));
    fdcont.text = "";
  }

  openWtApp() async {
    String text =
        'https://wa.me/+91 1234567890?text=Hello Yum Eats , i wanted to enquire about the product ';
    await launch(text);
  }

  getLocation() async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await launch(googleUrl);
  }

  callContact() {
    launch("tel://214324234");
  }

  logout() async {
    await _firebaseAuth.signOut();
  }

  GotoEditAC() => Get.to(EditAc());

  GotoOrders()=> Get.to(Refrence());
}
