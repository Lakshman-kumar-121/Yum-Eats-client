import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AdditionalScreen/Itemview/Itemview.dart';

class searchgridcontroller extends GetxController {
  RxInt itemcount = 0.obs;
  var style_list = {};
  var list;
  var rating = [];
  var _Firebasefirestore = FirebaseFirestore.instance;
  TextEditingController searchTextController = TextEditingController();

  Future getAllitems(categoryname) async {
    style_list = {};
    list = 0;
    rating.clear();
    itemcount.value = 0;

    var doc = await _Firebasefirestore.collection("Food").doc("Category").get();
    var data = doc.data();
    int loop = data?.keys.length ?? 0;

    if (doc.data()!.keys.contains(categoryname)) {
      
      var c =
          await _Firebasefirestore.collection("Food").doc(categoryname).get();
      style_list = c.data()!;
      for (int x = 0; x < style_list.length; x++) {
        var allstar = style_list.values.elementAt(x)["rating"]["star"].values;

        rating.add((allstar.reduce((c, d) => c + d) / allstar.length)
            .toStringAsFixed(1));
      }
    } else {
      for (var x = 0; x < loop; x++) {
        var c = await _Firebasefirestore.collection("Food")
            .doc(data?.keys.elementAt(x))
            .get();
       list = c.data();
        var catlen = c.data()?.length ?? 0;

        for (int y = 0; y < catlen; y++) {
          var allstar = list?.values.elementAt(y)["rating"]["star"].values;
          if (allstar.length == 0){
            rating.add(0);
          }
          else{
            rating.add((allstar.reduce((c, d) => c + d) / allstar.length)
              .toStringAsFixed(1));
          }

          style_list[list?.keys.elementAt(y)] = list?.values.elementAt(y);
        }
      }
    }

    itemcount.value = style_list.length;

    var present = false;
    doc.data()?.forEach((key, value) {
      if (key == categoryname) {
        present = true;
      }
    });

    if (categoryname != "all" && !present) {
      itemcount.value = style_list.length;
      
      SearchItem(categoryname);
    }
  }

  SearchItem(itemname) {
    print("tihs is tru");
    searchTextController.clear();
    var wastedata = [];

    style_list.keys.toList().asMap().forEach((index, items) {
      if (items.toLowerCase().contains(itemname)) {
      } else {
        wastedata.add(items);
        print(items);
      }
    });

    for (int x = 0; x < wastedata.length; x++) {
      style_list.remove(wastedata.elementAt(x));
    }

    itemcount.value = style_list.length;
  }

  Future itemview(item, index, categoryname) async {
    var doc = await _Firebasefirestore.collection("Food").doc("Category").get();
    if (doc.data()!.keys.contains(categoryname)) {
      Get.to(Itemview(
        itemlist: item,
        index: index,
      ));
    } else {
      Get.to(Itemview(
        itemlist: item,
        index: index,
      ));
    }
  }

  void showemptysearch() {
    Get.showSnackbar(GetSnackBar(
      title: "Error",
      message: "search cannot be empty",
      duration: Duration(seconds: 1),
    ));
  }
}
