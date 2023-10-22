import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/main.dart';

class FavrouteController extends GetxController {
  var fav;
  var nameslist;
  var imagelist = [];
  var pricelist = [];
  var categorylist;
  RxInt listlen = 0.obs;
  var _firebasefirestore = FirebaseFirestore.instance;
  Future getdata(data) async {
    await cleardata();
    
    fav = data['fav'];
    if (fav != null) {
      nameslist = fav.keys;
      categorylist = fav.values;
      listlen.value = categorylist.length;

      for (int x = 0; x < categorylist.length; x++) {
        var d = await _firebasefirestore
            .collection("Food")
            .doc(categorylist.elementAt(x))
            .get();
        var c = d.data()![nameslist.elementAt(x)];
        imagelist.insert(x, c['img'].elementAt(0));
        pricelist.insert(x, c['price']);
      }
    }
    
  }

  Future addtocart(index) async {
    await _firebasefirestore.collection("users").doc(Cur_user_id).set({
      "cart": {
        nameslist.elementAt(index): {
          "Category": categorylist.elementAt(index),
          "quantity": 1
        }
      }
    }, SetOptions(merge: true));
    Get.snackbar("Cart", "Succesfully added this item to cart",
        snackPosition: SnackPosition.BOTTOM,
        borderWidth: 2,
        shouldIconPulse: false,
        icon: Icon(
          Icons.check_circle,
          size: 40,
          color: Colors.green,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        colorText: Colors.white,
        borderColor: Colors.white,
        backgroundColor: Colors.black54,
        margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20));
  }

  Future removefav(index) async {
    var d = await _firebasefirestore.collection("users").doc(Cur_user_id).get();
    var c = d.data();
    c?['fav'].remove(nameslist.elementAt(index));
    var e = c;
    await _firebasefirestore.collection("users").doc(Cur_user_id).set(e!);
    Get.snackbar("Remove", "Succesfully removed this item from your favroute",
        snackPosition: SnackPosition.BOTTOM,
        borderWidth: 2,
        shouldIconPulse: false,
        icon: Icon(
          Icons.check_circle,
          size: 40,
          color: Colors.green,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        colorText: Colors.white,
        borderColor: Colors.white,
        backgroundColor: Colors.black54,
        margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20));
   
  }

  Future cleardata() async {
    fav = null;
    nameslist = null;
    // imagelist.clear();
    //pricelist.clear();
    categorylist = null;
  }
}
