import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/main.dart';

class MyCartController extends GetxController {
  var cartdata;
  
  var firebaseinstace = FirebaseFirestore.instance;
  var price = [].obs;
  var link = [];
  var item;
  var category = [];
  RxInt itemlen = 0.obs;
  var qnt = [].obs;
  RxInt qntitem = 0.obs;
  RxInt totalprice = 0.obs;
  RxInt totalitem = 0.obs;
  RxInt finalprice = 0.obs;
  
  BuyNow() async {
    
    var rng = Random();
    var dte = DateTime.now();
    var tme =
        "${dte.year}-${dte.month}-${dte.day}-:${dte.hour}:${dte.minute < 10? "0" + dte.minute.toString() : dte.minute.toString() }::${Cur_user_id}";
    var refid = tme + "::${rng.nextInt(10000000)}";
    var dt = DateTime.now();
    var date = dt.day.toString() +
        "-" +
        dt.month.toString() +
        "-" +
        dt.year.toString();
    var data = {};
    var dm = {};
    for (int r = 0; r < itemlen.value; r++) {
      dm["${item.elementAt(r)}"] = {
        "Category": category.elementAt(r),
        "Quantity": "${qnt.value.elementAt(r)}"
      };
    }
    data["Items"] = dm;
    data["Price total"] = totalprice.value.toString();
    data["Time"] = DateTime.now().toString();
    await FirebaseDatabase.instance
        .ref()
        .child("Orders/${Cur_user_id}")
        .child("Pending")
        .update({refid.toString(): data});


   
    await FirebaseDatabase.instance
        .ref()
        .child("Daily Order")
        .child(date)
        .child("Pending")
        .child(refid.toString())
        .set("");
    removeallfav();
    print("hehe after");
  }

  removeallfav() async {
    firebaseinstace
        .collection("users")
        .doc(Cur_user_id)
        .set({'cart': {}}, SetOptions(merge: true));

  }

  Future getcartdata( data) async {
    print(await FirebaseAuth.instance.currentUser?.displayName);
    getaddress();
     clearalldata();
    totalitem.value = 0;
    totalprice.value = 0;
    finalprice.value = 0;
    print(Cur_user_id);
    // await FirebaseAuth.instance.signOut();
    if (data['cart'] !=null){
  var c = data['cart'];
    item = c.keys;
    itemlen.value = item.length;
    price.length = itemlen.value;
    category.length = itemlen.value;
    for (int x = 0; x < item.length; x++) {
      await getitemdat(x, c);
      
    }

    itemlen.value > 0 ?  totalitem.value = qnt.reduce((c, d) => c + d) : "";
    }
  

   
  }


  Future getitemdat(x ,c)
  async{
   
    category.insert(x, c[item.elementAt(x)]['Category']);
    
    print(category.elementAt(x));
    print(item.elementAt(x));
    
      var z = await firebaseinstace
          .collection("Food")
          .doc(category.elementAt(x))
          .get();

      print(z.data());
      var itm = z.data()?[item.elementAt(x)];
      price.removeAt(x);
      price.insert(x, itm['price']);
      
      link.add( itm['img'].elementAt(0));
      qnt.add( c[item.elementAt(x)]['quantity']);
      
      totalprice += qnt[x] * price[x];
      finalprice.value = totalprice.value + 10;
      print("end here");
      print(link);

  }

  increaseqnt(index) async {
    totalprice.value = 0;
    qnt[index] += 1;
    for (int x = 0; x < item.length; x++) {
      totalprice += qnt[x] * price[x];
    }
    totalitem.value = qnt.reduce((c, d) => c + d);
    
    await firebaseinstace.collection("users").doc(Cur_user_id).set({
      "cart": {
        item.elementAt(index): {"quantity": qnt[index]}
      }
    }, SetOptions(merge: true));
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
var amount =  "$finalprice" ; // Your desired amount parameter value

var response = await http.post(
  url,
  body: {'amount': amount},
);
        // print("hhe");
  // var response = await http.post(
          // Uri.parse(
              // 'http://192.168.137.1:3000/'),);
      
      

      final jsonResponse = jsonDecode(response.body);
      print("got till here");
      print(jsonResponse.toString());
      // 2. Initialize the payment sheet
      // await Stripe.instance.initPaymentSheet(
      //     paymentSheetParameters: SetupPaymentSheetParameters(
      //   paymentIntentClientSecret: jsonResponse['paymentIntent'],
      //   merchantDisplayName: 'Safelock',
      //   customerId: jsonResponse['customer'],
      //   customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
      //   merchantCountryCode: 'SG',
      // ));
      // await Stripe.instance.presentPaymentSheet();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Payment is successful'),
      //   ),
      // );
      await BuyNow();
    } catch (errorr) {
      // if (errorr is StripeException) {
      //   ScaffoldMessenger.of(context).showSnackBar(

      //     SnackBar(
           
      //       content: Text('An error occured ${errorr.error.localizedMessage}'),
      //     ),
      //   );
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
            
      //       content: Text('An error occured  $errorr\n\n\n\n'),
      //     ),
      //   );
      // }
    }
  }




  decrementqnt(index) async {
    totalprice.value = 0;
    qnt[index] -= 1;
    for (int x = 0; x < item.length; x++) {
      totalprice += qnt[x] * price[x];
    }

    totalitem.value = qnt.reduce((c, d) => c + d);
    await firebaseinstace.collection("users").doc(Cur_user_id).set({
      "cart": {
        item.elementAt(index): {"quantity": qnt[index]}
      }
    }, SetOptions(merge: true));
  }

  deleteitem(index) async {
    await firebaseinstace
        .collection("users")
        .doc(Cur_user_id)
        .update({"cart.${item.elementAt(index)}": FieldValue.delete()});
  }

   clearalldata() async {
    totalprice.value = 0;
    category.clear();
    qnt.clear();
    link.clear();
    return;

  }
  var add = "";
  getaddress()async{

    var  d= await firebaseinstace.collection("users").doc(Cur_user_id).get();
    add = d.data()?["Personaldata"]["Address"];
  }
}
