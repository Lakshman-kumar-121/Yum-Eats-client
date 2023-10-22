import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AccountScreens/camera/camera.dart';
import 'package:screens/Main/AccountScreens/camera/cameraclick.dart';
import 'package:screens/Main/NavigationScreen/editac/Imageview.dart';
import 'package:screens/main.dart';

class EditAccountController extends GetxController {
  var countrycode;
  var signup_number = TextEditingController();
  TextEditingController nameTController = TextEditingController();
  TextEditingController mailTController = TextEditingController();
  TextEditingController addresTController = TextEditingController();
  TextEditingController numberTController = TextEditingController();


  var us;

  var _firebseafirestore = FirebaseFirestore.instance;
  var _firebaseStorage = FirebaseStorage.instance;
  
  RxString Gender = "Male".obs;
  var data;
  Rx photoUrl =
      "https://firebasestorage.googleapis.com/v0/b/restaurant-9bbe6.appspot.com/o/Accessory%2FAuthentication%2FDummy%20profile.jpg?alt=media&token=0700b192-69a0-4242-af92-98b31b22c051"
          .obs;



  Future removepic()async{
    var d = await _firebseafirestore.collection("users").doc(Cur_user_id).get();
    var dat = d.data();
    dat?['Personaldata']['Photo'] = "https://firebasestorage.googleapis.com/v0/b/restaurant-9bbe6.appspot.com/o/Accessory%2FAuthentication%2FDummy%20profile.jpg?alt=media&token=0700b192-69a0-4242-af92-98b31b22c051";

    await _firebseafirestore.collection("users").doc(Cur_user_id).set(dat?? {} , SetOptions(merge: true));
    Get.back(closeOverlays: true);
    Get.back();

  }
  Future Getdata() async {
    
    
    var d = await _firebseafirestore.collection("users").doc(Cur_user_id).get();
    data = d.data();

    nameTController.text = d.data()?['Personaldata']['Name'] ?? "";
    mailTController.text = d.data()?['Personaldata']['Email'] ?? "";
    photoUrl.value = d.data()?['Personaldata']['Photo'];
    Gender.value = d.data()?['Personaldata']['Gender'];
    numberTController.text = d.data()?['Personaldata']['Number'];
    addresTController.text = d.data()?['Personaldata']['Address'];
  }

  updateprofile() async {
    await _firebseafirestore.collection("users").doc(Cur_user_id).set({
      "Personaldata": {
        "Name": nameTController.text.trim(),
        "Email": mailTController.text.trim(),
        "Photo": photoUrl.value,
        "Address": addresTController.text.trim(),
        "Gender": Gender.value,
        "Number": "+91 8095222577",
        "Photo": data['Personaldata']['Photo'],
        "StripeId": data['Personaldata']['StripeId'],
        "UID": Cur_user_id,
      }
    }, SetOptions(merge: true));
    // await user?.updateDisplayName(textvalue(nameTController));
    
    await updatecustomer(nameTController.text.trim(), mailTController.text.trim());
    Get.back();
  }

 Future updatecustomer(name, email) async {
    try {
      var d =
          await _firebseafirestore.collection("accessory").doc("Payment").get();
      var token = d.data()?['token'];
      var a = await _firebseafirestore.collection("users").doc(Cur_user_id).get();
      var StripeId = a.data()?['Personaldata']['StripeId'];
      var data = {
        'name': name,
      };
      data['email'] = email;
      var response = await Dio().post(
        'https://api.stripe.com/v1/customers/${StripeId}',
        data: data,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            validateStatus: (status) => true,
            headers: {
              'Authorization': 'Bearer ${token}', // your secret key
            }),
      );
      return response;
    } catch (err) {
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: err.toString(),
      ));
    }
  }
  opencamera(){
    return Get.to(()=> MyCamera());
  }


  textvalue(text) {
    return text.text.trim();
  }

  PlatformFile? file = null;
  Future SelectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    file = result.files.first;
    Get.to(CameraClick(image: file));
  }

  gotoImageview() {
    Get.to(ImageView(photoUrl.value));
  }
}
