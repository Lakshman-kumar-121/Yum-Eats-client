import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AdditionalScreen/Orders/Order.dart';
import 'package:screens/Realtimedb/demo.dart';
import 'package:screens/main.dart';

class RefrenceController extends GetxController {
  var _firebaseDatabase = FirebaseDatabase.instance;
  var refId = [];
  var date = [];
  var price = [];
  var len = 0;
  var dta;

  
  var orrefId = [];
  var ordate = [];
  var orprice = [];
  var orlen = 0;
  var ordta;

  
  

  getData() async {
    cleardata();

    await _firebaseDatabase
        .ref()
        .child("Orders/${Cur_user_id}/Pending")
        .once()
        .then((ref) {
      if (ref.snapshot.value != null) {
        dta = ref.snapshot.value as Map;
        print(dta);
        len = dta.length;
        refId.length = len;
        date.length = len;
        price.length = len;
        for (int x = 0; x < len; x++) {
          var id = dta.keys.elementAt(x).toString().split("::")[2];
          refId[x] = id;

          price[x] = dta.values.elementAt(x)["Price total"];
          var d = dta.values.elementAt(x)["Time"];
          int s = d.indexOf(".");
          date[x] = d.substring(0, s).trim();
        }
      }
      
    });

        await _firebaseDatabase
        .ref()
        .child("Orders/${Cur_user_id}/Order")
        .once()
        .then((ref) {
      if (ref.snapshot.value != null) {
        print("hello");
        ordta = ref.snapshot.value as Map;
        
        orlen = ordta.length;
        orrefId.length = orlen;
        ordate.length = orlen;
        orprice.length = orlen;
        for (int x = 0; x < orlen; x++) {
          var id = ordta.keys.elementAt(x).toString().split("::")[2];
          orrefId[x] = id;

          orprice[x] = ordta.values.elementAt(x)["Price total"];
          var d = ordta.values.elementAt(x)["Time"];
          int s = d.indexOf(".");
          ordate[x] = d.substring(0, s).trim();
        }
      }
      
    });
  }

  cleardata() {
    dta = 0;
    refId = [];
    date = [];
    price = [];
    len = 0;

    ordta = 0;
    orrefId = [];
    ordate = [];
    orprice = [];
    orlen = 0;
  }

  gotoOrder(index , order) => Get.to(MyOder(
        itmindex: index,
        data: order ? dta.values : ordta.values,
      ));
}
