import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/NavigationScreen/cart/mycartcont.dart';
import 'package:screens/Main/NavigationScreen/cart/cartload.dart';
import 'package:screens/main.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key});
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var mycartcont = Get.put(MyCartController());
  
  @override
  Widget build(BuildContext context) {
   
   
   
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(Cur_user_id)
            .snapshots(),
        
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CartLoading();
          }

          return FutureBuilder(
              future: mycartcont.getcartdata(snapshot.data?.data()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CartLoading();
                }
                return Scaffold(
                    extendBody: true,
                    body: Container(
                      padding: EdgeInsets.symmetric(vertical: 23),
                      child: Stack(
                        children: [cartitem(context), cartcount(context)],
                      ),
                    ));
              });
        });
  }

  Container cartitem(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Cart",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.black54,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
              child: Obx(() {
                if (mycartcont.itemlen.value <= 0) {
                  return no_item();
                }
                return ListView.builder(
                  itemCount: mycartcont.itemlen.value,
                  itemBuilder: (context, index) => view(index),
                );
              })),
        ],
      ),
    );
  }

  view(index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 253, 234, 211),
          borderRadius: BorderRadius.circular(25)),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network("${mycartcont.link.elementAt(index)}",
                width: 100, height: 100, fit: BoxFit.cover),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " ${mycartcont.item.elementAt(index)}",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8,
              ),
              Obx(
                () => Text(
                  "  Price ${mycartcont.price.elementAt(index)}/-",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        if (mycartcont.qnt.elementAt(index) > 1) {
                          mycartcont.decrementqnt(index);
                        } else {
                          Get.snackbar("Warning", "Quantity cannot be zero",
                              snackPosition: SnackPosition.BOTTOM,
                              borderWidth: 2,
                              icon: Icon(
                                Icons.cancel,
                                size: 40,
                                color: Colors.red,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              colorText: Colors.white,
                              borderColor: Colors.white,
                              backgroundColor: Colors.black54,
                              margin: EdgeInsets.symmetric(
                                  vertical: 100, horizontal: 20));
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        size: 35,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    Obx(() {
                      if (mycartcont.qnt.length < mycartcont.itemlen.value) {
                        return Container();
                      }
                      return Text(
                        "${mycartcont.qnt.value.elementAt(index)}",
                        style: TextStyle(fontSize: 22),
                      );
                    }),
                    IconButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        if (mycartcont.qnt.elementAt(index) < 10) {
                          mycartcont.increaseqnt(index);
                        } else {
                          Get.snackbar("Warning", "Quantity over loaded",
                              snackPosition: SnackPosition.BOTTOM,
                              borderWidth: 2,
                              icon: Icon(
                                Icons.cancel,
                                size: 40,
                                color: Colors.red,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              colorText: Colors.white,
                              borderColor: Colors.white,
                              backgroundColor: Colors.black54,
                              margin: EdgeInsets.symmetric(
                                  vertical: 100, horizontal: 20));
                        }
                      },
                      icon: Icon(
                        Icons.add_circle_outline_rounded,
                        color: Colors.black,
                        size: 35,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    IconButton(
                        onPressed: () {
                          mycartcont.deleteitem(index);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              )
            ],
          )
        ],
      ),
      height: 136,
      width: double.maxFinite,
    );
  }

  no_item() {
    return Center(
      child: Text(
        "Cart is empty",
        style: TextStyle(fontSize: 40),
      ),
    );
  }

  Column cartcount(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 18, bottom: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => Text(
                  "Total items: ${mycartcont.totalitem}",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Item charges",
                    style: TextStyle(fontSize: 16),
                  ),
                  Obx(() =>Text(
                    "${mycartcont.totalprice}/-",
                    style: TextStyle(fontSize: 16),
                  ) )
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Service charges",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "10/-",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 1,
                    color: Colors.black,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Net amount",
                    style: TextStyle(fontSize: 16),
                  ),
                  Obx(() => Text(
                        "${mycartcont.finalprice}/-",
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      elevation: 0,
                      minimumSize: Size(double.maxFinite, 50)),
                  onPressed: () {
                    // mycartcont.initPayment(amount: 500 ,context: context ,);
                     if(mycartcont.totalprice !=0){
placeorder();
                     }else{
                   Get.snackbar("Warning", "Amount is zero",
                              snackPosition: SnackPosition.BOTTOM,
                              borderWidth: 2,
                              icon: Icon(
                                Icons.cancel,
                                size: 40,
                                color: Colors.red,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              colorText: Colors.white,
                              borderColor: Colors.white,
                              backgroundColor: Colors.black54,
                              margin: EdgeInsets.symmetric(
                                  vertical: 100, horizontal: 20));
                     }
                     
                  },
                  child: Text(
                    "Place order",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ))
            ],
          ),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 217, 217, 217),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2.5,
        )
      ],
    );
  }

  placeorder() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height / 5,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deliver address",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Divider(),
                Text("${mycartcont.add}",
                    style: TextStyle(fontWeight: FontWeight.w400)),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Net amount",
                        style: TextStyle(fontWeight: FontWeight.w400)),
                    Text("${mycartcont.finalprice}/-",
                        style: TextStyle(fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 3, 40)),
                    child: Text("Cancel")), 
                ElevatedButton(
                    onPressed: () {
                      // mycartcont.initPayment(amount: 500 ,context: context ,);
mycartcont.BuyNow();

                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 3, 40)),
                    child: Text("Pay"))
              ],
            )
          ],
        ),
      );
}
