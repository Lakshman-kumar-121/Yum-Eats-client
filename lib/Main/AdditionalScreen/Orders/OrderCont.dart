import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  var _firebaseFirestore = FirebaseFirestore.instance;

  var qnt = [];
  var itmname = [];
  var catename = [];
  var imglink = [];
  int len = 0;
  getData(itmindex ,data)async{
   var d =  data.elementAt(itmindex)['Items'];
   len = d.length;
   itmname.length = d.length;
   catename.length = d.length;
   qnt.length = d.length;
   imglink.length = d.length;


   for(int x = 0 ; x< len; x++){
    itmname[x] = d.keys.elementAt(x);
    catename[x] = d.values.elementAt(x)['Category'];
    qnt[x] = d.values.elementAt(x)['Quantity'];
    var dum = await _firebaseFirestore.collection("Food").doc(catename.elementAt(x)).get();
     imglink[x] = dum.data()?[itmname.elementAt(x)]['img'].elementAt(0);
   }



  }
}