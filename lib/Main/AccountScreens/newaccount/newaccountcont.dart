
import 'package:dio/dio.dart';
import 'package:get/get.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:screens/Main/Auth/Authcont.dart';
import 'package:screens/Main/AccountScreens/camera/cameraclick.dart';
import 'package:screens/Main/NavigationScreen/editac/Imageview.dart';
import 'package:screens/Main/LoginScreen/SignIn/signin.dart';
import 'package:screens/main.dart';
class NewAccountController extends GetxController{
  

  TextEditingController nameTController = TextEditingController();
  TextEditingController mailTController = TextEditingController();
  TextEditingController addresTController = TextEditingController();
  TextEditingController numberTController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfirmpasswordController = TextEditingController();
  RxBool showpassword = false.obs;
  RxBool showconfirmpassword = false.obs;
  var authCont = Get.find<AuthController>();
  var us;
  var b = FirebaseAuth.instance;
  var _firebseafirestore = FirebaseFirestore.instance;
  var _firebaseStorage = FirebaseStorage.instance;
  var _firebaseAuth = FirebaseAuth.instance;
  Rx photoUrl = "https://firebasestorage.googleapis.com/v0/b/restaurant-9bbe6.appspot.com/o/Accessory%2FAuthentication%2FDummy%20profile.jpg?alt=media&token=0700b192-69a0-4242-af92-98b31b22c051".obs;
  RxString Gender = "Male".obs;
  
  checkdetails(number , uid)async{
    
    if (nameTController.text.trim().isEmpty || mailTController.text.trim().isEmpty ||
     addresTController.text.trim().isEmpty ){
      Get.showSnackbar(GetSnackBar(title: "Incomplete field",
      message: 'Please fill all fields',));
      return;
     }
     if(passwordController.text.trim() == ConfirmpasswordController.text.trim()){
      
      await createAccount(number  ,uid);
      
    }
    else{
      Get.showSnackbar(GetSnackBar(title: "Mismatch",message: "Password does not match with Confirm password",duration: Duration(seconds: 2),));
    }
     


    
  }



  
Future createcustomer(name , email) async {
try {
  var d = await _firebseafirestore.collection("accessory").doc("Payment").get();
  var token = d.data()?['token'];
  var data = {
      'name': name,
    };
    data['email'] = email;
   var response = await Dio().post('https://api.stripe.com/v1/customers',
      data: data,
      
      options: Options(contentType:Headers.formUrlEncodedContentType,
      validateStatus: (status) => true,
          headers: {
            'Authorization': 'Bearer ${token}', // your secret key
          }
      ),
    );
    
  return response;


} catch (err) {
  print('err charging user: ${err.toString()}');
}

  }


updatecustomer(name , email)async{
  try {
  
  var d = await _firebseafirestore.collection("accessory").doc("Payment").get();
  var token = d.data()?['token'];
  var a = await _firebseafirestore.collection("users").doc("demo").get();
  var StripeId = a.data()?['Personaldata']['StripeId'];
  var data = {
      'name': name,
    };
    data['email'] = email;
   var response = await Dio().post('https://api.stripe.com/v1/customers/${StripeId}',
      data: data,
      
      options: Options(contentType:Headers.formUrlEncodedContentType,
      validateStatus: (status) => true,
          headers: {
            'Authorization': 'Bearer ${token}', // your secret key
          }
      ),
    );
  return response;


} catch (err) {
  Get.showSnackbar(GetSnackBar(title: "Error",message: err.toString(),));
}

}
createAccount(number , uid)async{
try{



      // Future.delayed(Duration.zero ,  () =>  newAccountDailog());
    
         
          await setaccountdetails(uid);
          Cur_user_id = uid; 
  await _firebaseAuth.createUserWithEmailAndPassword(email: mailTController.text.trim(), password: passwordController.text.trim() ).then((value) {
    value.user!.updateDisplayName(uid) ;
      Get.back();
  });
      
       
       
     }catch(e){
      Get.showSnackbar(GetSnackBar(title: "Error",message: e.toString(),duration: Duration(seconds: 2),));
     }
}


Future setaccountdetails(uid)
async{
  
        var stripeId  = await createcustomer(nameTController.text.trim(),mailTController.text.trim());   
       var userPersonalInfo = {
        "Personaldata":{
          "Name" : nameTController.text.trim(),
          "Email": mailTController.text.trim(),
          "Photo": photoUrl.value,
          "Address" : addresTController.text.trim(),
          "Gender": Gender.value,
          "Number" : numberTController.text.trim(),
          "StripeId" : stripeId.data['id'],
          "UID" : uid
        },
        "cart": {},
        "fav":{},
        "streak":{"Date": Timestamp.now() , "count": 0}
       };
       await _firebseafirestore.collection("users").doc(uid).set(userPersonalInfo);  
}
  void newAccountDailog() => Get.defaultDialog(
          title: "Account Information",
          titleStyle: TextStyle(
              height: 1.8,
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.w800,
              fontSize: 22),
          content: Text(
            "New account have sucessfully created",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5)),
                onPressed: () {
                  Get.back(closeOverlays: true);
                },
                child: Text(
                  "Okay",
                  style: TextStyle(fontSize: 17),
                ))
          ]);
Future updatephoto()async{
    photoUrl.value = _firebaseAuth.currentUser?.photoURL;
    
}

  updateprofile() async {
    var user = _firebaseAuth.currentUser;
 await _firebseafirestore.collection("users").doc("demo").set({"Personaldata" : {"Name"  : textvalue(nameTController)}} , SetOptions(merge: true));
  await user?.updateDisplayName(textvalue(nameTController));
  }


  Future createuser() async {
    
   
  }
  textvalue(text){
    return text.text.trim();
  }

PlatformFile? file = null;
Future SelectFile() async {
  final result = await FilePicker.platform.pickFiles();
  if (result == null) return;
    file = result.files.first;
    Get.to(CameraClick(image: file));
  }
  gotoImageview(){
    Get.to(ImageView(photoUrl.value));
  }
}


