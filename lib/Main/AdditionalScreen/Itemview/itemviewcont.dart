import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:screens/Main/AdditionalScreen/review/review.dart';
import 'package:screens/Main/NavigationScreen/fav/faccont.dart';
import 'package:screens/main.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
class ItemviewController extends GetxController {
  var firebaseinstance = FirebaseFirestore.instance;
  var images;
  var discriptin;
  var itemname;
  var category;
  int price = 0;
  String rating = "";
  RxBool isfav = false.obs;
 //  var fav = Get.find<FavrouteController>() ;
  changefav() async {
    isfav.value = !isfav.value;
    var b = await firebaseinstance.collection("users").doc(Cur_user_id).get();
    if (isfav.value == false) {
      var c = b.data();
      c?['fav'].remove(itemname);
      var d = c;
      await firebaseinstance.collection("users").doc(Cur_user_id).set(d!);
    } else {
      await firebaseinstance.collection("users").doc(Cur_user_id).set({
        "fav": {itemname: category}
      }, SetOptions(merge: true));
    }
    
    

  }

  addtocart() async {
    await firebaseinstance.collection("users").doc(Cur_user_id).set({
      "cart": {itemname:{ "Category" : category , "quantity": 1} }
      
    }, SetOptions(merge: true));
     Get.snackbar("Cart", "Succesfully added this item to cart",
snackPosition: SnackPosition.BOTTOM,
borderWidth: 2,
shouldIconPulse: false,
icon: Icon(Icons.check_circle,size: 40,
color: Colors.green, ),
padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    colorText: Colors.white,
                                    borderColor: Colors.white,
                                    backgroundColor: Colors.black54,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 100, horizontal: 20));
  }

   Future getData(list  , index ) async {
    getaddress();
    itemname = list.keys.elementAt(index);
    var d = await firebaseinstance.collection("Food").doc("Item Category").get();
    category =  d.data()?[itemname];
    price = list.values.elementAt(index)["price"];
    images = list.values.elementAt(index)["img"];
    discriptin = list.values.elementAt(index)["Discription"];
    var allstar = list.values.elementAt(index)["rating"]["star"].values;
    
    
    rating =  allstar.length == 0 ? '0': 
        (allstar.reduce((c, d) => c + d) / allstar.length).toStringAsFixed(1);
    var b = await firebaseinstance.collection("users").doc(Cur_user_id).get();
    var s = await b.data()?["fav"].containsKey(itemname);
    if (s!= null){
      isfav.value = s;
    }
    else{
      isfav.value  = false;
    }
  }
Future<void> initPayment(
      {
      required double amount,
      required BuildContext context}) async {
    try {
      
    
      // 1. Create a payment intent on the server
    

      // final response = await http.post(
      //     Uri.parse(
      //         'http://192.168.56.1:3000/') , );
      
    
    var url = Uri.parse('http://192.168.137.1:3000/');
var amount =  "${price + 10}" ; // Your desired amount parameter value

var response = await http.post(
  url,
  body: {'amount': amount},
);

      final jsonResponse = jsonDecode(response.body);
      print("got till here");
      print(jsonResponse.toString());
      // 2. Initialize the payment sheet
    //   await Stripe.instance.initPaymentSheet(
    //       paymentSheetParameters: SetupPaymentSheetParameters(
    //     paymentIntentClientSecret: jsonResponse['paymentIntent'],
    //     merchantDisplayName: 'Safelock',
    //     customerId: jsonResponse['customer'],
    //     customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
    //     merchantCountryCode: 'SG',
        
    //   ));
    //   await Stripe.instance.presentPaymentSheet();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Payment is successful'),
    //     ),
    //   );
    } catch (errorr) {
    //   if (errorr is StripeException) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('An error occured ${errorr.error.localizedMessage}'),
    //       ),
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
            
    //         content: Text('An error occured  $errorr\n\n\n\n\n\n\n\n\n\n\nn\n\n\n'),
    //       ),
    //     );
    //   }
    }
  }var add = "";
  getaddress()async{
    var  d= await firebaseinstance.collection("users").doc(Cur_user_id).get();
    add = d.data()?["Personaldata"]["Address"];
  }
  gotoreview()=> Get.to(Review(name: itemname, category: category));
}
