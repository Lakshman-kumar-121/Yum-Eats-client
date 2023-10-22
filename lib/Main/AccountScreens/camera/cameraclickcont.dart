
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AccountScreens/camera/circleloading.dart';
import 'package:screens/Main/NavigationScreen/editac/editaccont.dart';
import 'package:screens/main.dart';
import 'package:path/path.dart';
class CameraClickController extends GetxController{
  var _firebaseStorage = FirebaseStorage.instance;
  var _firebaseFirestore = FirebaseFirestore.instance;
  var _firebaseAuth  = FirebaseAuth.instance;
  var url;
    Future uploadtostorage(file) async{
    if(file != null){
    Get.to( CircleLoadingNew());
    var s  = File("asd");
    
    String storagepath = "Users/${Cur_user_id}/${basename(file.path)}";
    final uploadfile = File(file!.path!);
    final ref = FirebaseStorage.instance.ref().child(storagepath);
    await ref.putFile(uploadfile);
    url = await ref.getDownloadURL();
    await _firebaseAuth.currentUser!.updatePhotoURL(url);
  await _firebaseFirestore.collection("users").doc(Cur_user_id).set({"Personaldata" : {"Photo": url} }  , SetOptions(merge: true) );
    file = null;

    await changeEditAcPhoto();
    
    Get.back(canPop: true);
    Get.back(canPop: true);
    }
    else{
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: "No file is selected",
      ));
    }
  }
  Future RemoveProfile()async{
    var dt = await  _firebaseFirestore.collection("accessory").doc("User").get();
    print(dt.data());
  }


  changeEditAcPhoto(){
    print("changed the image url");
    print(url);
var profil = Get.find<EditAccountController>();
profil.photoUrl.value = url;
  }
}