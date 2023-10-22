import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:screens/Main/NavigationScreen/Allcategory/allcategory.dart';
import 'package:screens/Main/NavigationScreen/Allcategory/searchgridcont.dart';
import 'package:screens/Sub/Navigation4/Navigation.dart';

class HomeController extends GetxController {

  TextEditingController searchtext= TextEditingController();
  var firestoreInstance = FirebaseFirestore.instance;
  var images = [];
  var category;

  getspecialthree() async {
    var a = await firestoreInstance
        .collection("accessory")
        .doc("daily_special")
        .get();

    images = a.data()?[DateFormat('EEEE').format(DateTime.now())];

    await getCategory();
  }

  getCategory() async {
    var a = await FirebaseFirestore.instance
        .collection("Food")
        .doc("Category")
        .get();
    category = a.data();
  }

  OpenCategory(ind )async{
    navicont.index = 1;
    var searchcont = Get.find<searchgridcontroller>();
    await searchcont.getAllitems(ind.toString());
    
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => searchscreen(style: )));
  }

  searched(text)async{
    navicont.index = 1;
    var searchcont = Get.find<searchgridcontroller>();
    await searchcont.getAllitems(text.toString());
    searchtext.clear();
  }

}
