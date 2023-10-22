import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:screens/Main/NavigationScreen/profile/profilecont.dart';
import 'package:screens/Main/NavigationScreen/profile/profileload.dart';
import 'package:screens/Sub/Navigation4/Navigation.dart';
import 'package:screens/main.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  bool status = true;

  var _profileCont = Get.put(profileController());
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:  FirebaseFirestore.instance
        .collection("users")
        .doc(Cur_user_id)
        .snapshots()
      ,builder: (context, snapshot) {

      if (snapshot.connectionState == ConnectionState.waiting) {
        return ProfileLoading();
      }

      return FutureBuilder(
          future: _profileCont.getName(snapshot.data),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ProfileLoading();
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Your Account",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              body: SingleChildScrollView(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: CustomPaint(
                        painter: RPSCustomPainter(),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 50, top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  "Hello, \n${_profileCont.usName}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 50),
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  width: MediaQuery.of(context).size.height / 6,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons
                                                .local_fire_department_outlined,
                                            color: Colors.amberAccent,
                                            size: 55,
                                          ),
                                          Text(
                                            "${_profileCont.streak}",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          
                                        ],
                                      ),
                                      _profileCont.hot ? Container(width: 40,height: 4, color: Colors.redAccent.withOpacity(0.5),) : 
                                      Container(width: 40,height: 4, color: Colors.transparent,)
                                      ,
                                      Text(
                                        "Daily Streak",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 15, right: 15, bottom: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            height: 30,
                            color: Colors.black54,
                          ),
                          Text(
                            "Basic",
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.03),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width /
                                                2.45,
                                            60),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                      onPressed: () {
                                        _profileCont.GotoOrders();
                                      },
                                      label: Text(
                                        "Order      ",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      icon: Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 186, 212, 206),
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width /
                                                2.45,
                                            60),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                      onPressed: () {
                                        _profileCont.GotoEditAC();
                                      },
                                      label: Text(
                                        "Edit A/c",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      icon: Icon(Icons.people_outline,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 186, 212, 206),
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width /
                                                2.45,
                                            60),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                      onPressed: () {feedbackDialog();}, //
                                      label: Text(
                                        "Feeback",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      icon: Icon(
                                        Icons.card_travel,
                                        color: Colors.black,
                                      ),
                                    ),
                                    OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width /
                                                2.45,
                                            60),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                      onPressed: () async {
                                        _profileCont.openWtApp();
                                      },
                                      label: Text(
                                        "Contact",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      icon: Icon(
                                        Icons.support_agent_rounded,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 40),
                          Text(
                            "General",
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.04),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            child: Column(
                              children: [
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 88, 88, 88),
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width /
                                                .5,
                                            50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    onPressed: () async {
                                      _profileCont.getLocation();
                                    },
                                    icon: Icon(Icons.settings),
                                    label: Text(
                                      "Locate us",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w300),
                                    )),
                                SizedBox(height: 10),
                                OutlinedButton.icon(
                                    onPressed: () {
                                      _profileCont.logout();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width /
                                                .5,
                                            50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    icon: Icon(
                                      Icons.logout,
                                      color: Color.fromARGB(255, 88, 88, 88),
                                    ),
                                    label: Text(
                                      "Logout      ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 88, 88, 88),
                                          fontSize: 28,
                                          fontWeight: FontWeight.w300),
                                    )),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  feedback(context) {
    return showDialog(
        context: context,
        builder: (index) => AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              content: TextField(
//                controller: pc.feedbackmessage,
                style: TextStyle(fontSize: 20),
                maxLines: 5,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: "Feedback here", border: OutlineInputBorder()),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width / 3, 40)),
                        onPressed: () => {
                              Navigator.of(context).pop(),

                              // pc.feedbackmessage.clear()
                            },
                        child: Text("cancel")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width / 3, 40)),
                        onPressed: () {
                          // pc.feedback();
                          Navigator.of(context).pop();
                          if (true) //pc.feedbackmessage.text.isNotEmpty)
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Thankyou for your feedback")));
                          else
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please enter feedback"),
                            ));
                        },
                        child: Text("send"))
                  ],
                )
              ],
            ));
  }

  void feedbackDialog() => Get.defaultDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: "Feedback",
        titlePadding: EdgeInsets.symmetric(vertical: 10),
        content: TextField(
          controller: _profileCont.fdcont,
          maxLines: 4,
          style: TextStyle(fontSize: 20, color: Colors.black54),
          decoration: InputDecoration(
              hintText: "Nice app",
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle:
                  TextStyle(color: Colors.black45, fontSize: 20, height: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        ),
        onCancel: () {},
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Color.fromARGB(255, 186, 212, 206), width: 1),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(horizontal: 30)),
            onPressed: () {
              Get.back(closeOverlays: true);
            },
            child: Text("Cancel",
                style: TextStyle(fontSize: 17, color: Colors.black))),
        confirm: ElevatedButton(
          onPressed: () {
            Get.back(closeOverlays: true);
            _profileCont.feedback();
            
          },
          child: Text(
            "Send",
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: Color.fromARGB(255, 186, 212, 206),
              padding: EdgeInsets.symmetric(horizontal: 40)),
        ),
      );
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 186, 212, 206)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.9413333, 0);
    path0.quadraticBezierTo(size.width * 0.9998133, size.height * -0.0047739,
        size.width, size.height * 0.0753769);
    path0.quadraticBezierTo(size.width, size.height * 0.2361307, size.width,
        size.height * 0.7183920);
    path0.quadraticBezierTo(size.width * 1.0026133, size.height * 0.8741206,
        size.width * 0.9048000, size.height * 0.8849749);
    path0.cubicTo(
        size.width * 0.3574400,
        size.height * 0.9683920,
        size.width * 0.3560267,
        size.height * 0.9718593,
        size.width * 0.1046667,
        size.height * 0.9949749);
    path0.quadraticBezierTo(size.width * 0.0251733, size.height * 1.0062312, 0,
        size.height * 0.8992965);
    path0.quadraticBezierTo(
        0, size.height * 0.2734422, 0, size.height * 0.0648241);
    path0.quadraticBezierTo(size.width * -0.0003467, size.height * -0.0192462,
        size.width * 0.0706667, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
