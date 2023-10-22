import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/NavigationScreen/Home/HomeLoad.dart';
import 'package:screens/Main/NavigationScreen/Home/homecont.dart';
import 'package:screens/Main/NavigationScreen/Home/homegrid.dart';

class Home extends StatelessWidget {
  Home({super.key});
  var homecontroller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homecontroller.getspecialthree(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
              return HomeLoading();
            }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  
                  homecontroller.getCategory();
                },
                icon: Icon(Icons.home)),
            title: Text("Yum Eats"),
            backgroundColor: Color.fromARGB(255, 91, 75, 139),
          ),
          body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                        children: [
                          CustomPaint(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        "Discover Today's",
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      )),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 0),
                                      child: Text(
                                        "Special.",
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black),
                                      )),
                                  SizedBox(height: 10),
                                  CarouselSlider(
                                    items: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              "${homecontroller.images[0].values.elementAt(0)}",
                                              height: 150,
                                            ),
                                          ),
                                          Text(
                                            "${homecontroller.images[0].keys.elementAt(0)}",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              "${homecontroller.images[0].values.elementAt(1)}",
                                              height: 150,
                                            ),
                                          ),
                                          Text(
                                            "${homecontroller.images[0].keys.elementAt(1)}",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              "${homecontroller.images[0].values.elementAt(2)}",
                                              height: 150,
                                            ),
                                          ),
                                          Text(
                                            "${homecontroller.images[0].keys.elementAt(2)}",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      )
                                    ],
                                    options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        height:
                                            MediaQuery.of(context).size.height / 3.5),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            size: Size(
                                MediaQuery.of(context).size.width,
                                (MediaQuery.of(context).size.width * 1.7351851851851852)
                                    .toDouble()),
                            painter: RPSCustomPainter(),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.38),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Material(
                                    elevation: 10,
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.transparent,
                                    child: TextField(
                                      controller:  homecontroller.searchtext,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle: TextStyle(fontSize: 20),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              homecontroller.searched(homecontroller.searchtext.text.trim());
                                            },
                                            icon: Icon(
                                              Icons.search,
                                            ),
                                            iconSize: 35,
                                          ),
                                          hintText: "Search...",
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 20),
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20)),
                                    ),
                                  ),
                                ),
                                Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Categories",
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            homecontroller.OpenCategory("all");
                                          },
                                          child: Text(
                                            "See all",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20)),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 50),
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.52),
                              child: GridHome())
                        ],
                      ),
              )
          
        );
      }
    );
  }
}

//  Color.fromARGB(255, 253, 234, 211)

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 253, 234, 211)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.8699074);
    path0.quadraticBezierTo(size.width * 0.0002167, size.height * 0.9546852,
        size.width * 0.0850167, size.height * 0.9567222);
    path0.cubicTo(
        size.width * 0.2928250,
        size.height * 0.9579954,
        size.width * 0.7084417,
        size.height * 0.9605417,
        size.width * 0.9162500,
        size.height * 0.9618148);
    path0.quadraticBezierTo(size.width * 1.0052167, size.height * 0.9590370,
        size.width, size.height * 0.8789444);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
