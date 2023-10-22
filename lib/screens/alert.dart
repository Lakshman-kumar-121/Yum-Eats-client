import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                OrderplacedDialog();
              },
              child: Text("press"))
        ],
      ),
    );
  }

  void PaymentDialog() => Get.defaultDialog(
        title: "Delivery address",
        backgroundColor: Color.fromARGB(255, 217, 217, 217),
        titleStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        contentPadding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
        content: Column(
          children: [
            Divider(
              thickness: 1.5,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "A block main road, kudlu gate branch, bangalore - 100",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Net Amount",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                Text(
                  "320/-",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
        onCancel: () {},
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(horizontal: 25)),
            onPressed: () {
              Get.back(closeOverlays: true);
            },
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 17, color: Colors.black),
            )),
        confirm: ElevatedButton(
          onPressed: () {},
          child: Text(
            "Pay",
            style: TextStyle(fontSize: 17),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 40)),
        ),
      );

  void OrderplacedDialog() => Get.defaultDialog(
          title: "Order Placed !",
          titleStyle: TextStyle(
              color: Colors.greenAccent[400],
              fontWeight: FontWeight.w800,
              fontSize: 25),
          titlePadding: EdgeInsets.only(bottom: 0, top: 18),
          contentPadding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 1.5,
              ),
              Text(
                "Order Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Total Amount (Rs)",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Quantity",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "1542",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "150/-",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "1 pc",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
              ),
              Text(
                "Address : A block main road, kudlu gate branch, bangalore - 100",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Icon(
                  Icons.check_circle_outlined,
                  color: Colors.greenAccent[400],
                  size: 80,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5)),
                onPressed: () {
                  Get.back(closeOverlays: true);
                },
                child: Text(
                  "Home",
                  style: TextStyle(fontSize: 17),
                ))
          ]);

  void ProfileUpdatedDialog() => Get.defaultDialog(
          title: "Profile Updated",
          titleStyle: TextStyle(
              height: 1.8,
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.w800,
              fontSize: 22),
          content: Text(
            "All your account details has been successfully changed",
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
  
  void RatingThnx() => Get.defaultDialog(
          backgroundColor: Color.fromARGB(255, 218, 218, 218),
          title: "Thank you for rating",
          titlePadding: EdgeInsets.symmetric(vertical: 20),
          titleStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          content: Text(
            "Your rating and review will be shared on this item. This will help others to know more about this app. Try our other food and provide feedback to improve us",
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 0),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 5)),
                  onPressed: () {
                    Get.back(closeOverlays: true);
                  },
                  child: Text(
                    "Okay",
                    style: TextStyle(fontSize: 17),
                  )),
            ),
          ]);
  void StreakDialog() => Get.defaultDialog(
          title: "Daily Streak",
          titleStyle: TextStyle(
              height: 1.8,
              color: Colors.amberAccent,
              fontWeight: FontWeight.w800,
              fontSize: 28),
          content: Column(
            children: [
              Icon(
                Icons.local_fire_department_outlined,
                size: 50,
                color: Colors.amberAccent,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Yahooooooo!",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                "Daily streak increased to 2",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              )
            ],
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5)),
                onPressed: () {Get.back(closeOverlays: true);},
                child: Text(
                  "Okay",
                  style: TextStyle(fontSize: 17),
                ))
          ]);
}
