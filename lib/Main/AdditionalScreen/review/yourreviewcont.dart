import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AdditionalScreen/review/urreview.dart';
import 'package:screens/main.dart';

class YourReviewController extends GetxController {
  
  var _firebaseFirestore = FirebaseFirestore.instance;
  var name;
  RxInt rate = 0.obs;
  TextEditingController yourReviTCont = TextEditingController();

  var itm ;
  var cat ;
  RxInt len = 0.obs;

  var nameList = [];
  var disList = [];
  var timeList = [];
  var starList = [];
  var allreview;
  var allstar;
  getData( itms , cats  ) async {
    
    itm = itms;
    cat = cats;
    var d = await _firebaseFirestore.collection("Food").doc(cat).get();
    allreview = d.data()?["${itm}"]["rating"]["review"];
    allstar = d.data()?["${itm}"]["rating"]["star"];
    if (allreview!= null){
          len.value = allreview.length;
    nameList.length = len.value;
    disList.length = len.value;
    timeList.length = len.value;
    starList.length = len.value;
    }

    for (int x = 0; x < len.value; x++) {
      nameList[x] = allreview.values.elementAt(x)['name'];
      
      
      disList[x] = allreview.values.elementAt(x)['discription'];
      var tm = allreview.values.elementAt(x)['time'];
      starList[x] = allstar.values.elementAt(x);

      var datetime = DateTime.fromMillisecondsSinceEpoch(tm.seconds * 1000);
      var split = datetime.toString().split(":");

      timeList[x] = split.elementAt(0) + ":" + split.elementAt(1);
    }
  }

  getYourData()async {
    var d = await _firebaseFirestore.collection("users").doc(Cur_user_id).get();
    if(allreview[Cur_user_id.toString()]!= null){
yourReviTCont.text = allreview[Cur_user_id.toString()]["discription"];
rate.value = allstar[Cur_user_id.toString()] - 1;
}
name = d.data()?["Personaldata"]["Name"];

    
  }

  updateReview() async {
    try {
      if (yourReviTCont.text.trim().isNotEmpty) {
        var uId = Cur_user_id;
        allreview[uId] = {
          "discription": yourReviTCont.text.trim(),
          "name": name,
          "time": Timestamp.now()
        };
        allstar[uId] = rate.value + 1;
        var d =
            await _firebaseFirestore.collection("Food").doc(cat).get();
        var dun = d.data();
        dun![itm]["rating"]['review'] = allreview;
        dun[itm]["rating"]['star'] = allstar;
        await _firebaseFirestore
            .collection("Food")
            .doc(cat)
            .set(dun, SetOptions(merge: true));
        yourReviTCont.text = "";
        
        RatingThnx();
      } else {
        Get.showSnackbar(GetSnackBar(
          title: "Incomplete Fields",
          message: "Please fill review to submit your review",
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: "Something went wrong at $e",
      ));
    }
  }

  void RatingThnx() => Get.defaultDialog(
          backgroundColor: Color.fromARGB(255, 218, 218, 218),
          title: "Thank you for rating",
          titlePadding: EdgeInsets.symmetric(vertical: 20),
          titleStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          content: Text(
            "Your rating and review will be shared on this item and it may take upto few hours to fully update. This will help others to know more about this app. Try our other food and provide feedback to improve us",
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 0),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 5)),
                  onPressed: () {
                    Get.back(closeOverlays: true);
                  },
                  child: Text(
                    "Okay",
                    style: TextStyle(fontSize: 17),
                  )),
            ),
          ]);

  gotowriteRe() => Get.to(YourReview());
}
