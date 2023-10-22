import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/Main/NavigationScreen/Home/homecont.dart';

class GridHome extends StatelessWidget {
  GridHome({Key? key}) : super(key: key);
  var homecontroller = Get.find<HomeController>();
  bool curcolor = true;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            childAspectRatio: 2 / 2.5),
        itemCount: homecontroller.category.length,
        itemBuilder: (context, index) {
          color();
          return GridTile(
            child: Material(
              child: InkWell(
                onTap: () {
                  homecontroller.OpenCategory(homecontroller.category.keys.elementAt(index  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                  decoration: BoxDecoration(
                      color: curcolor
                          ? Color.fromARGB(255, 207, 221, 255)
                          : Color.fromARGB(255, 186, 212, 206),
                      borderRadius: BorderRadius.circular(15)),
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                            "${homecontroller.category.values.elementAt(index)}",
                            fit: BoxFit.cover,
                            height: 150),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "${homecontroller.category.keys.elementAt(index)}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void color() {
    curcolor = !curcolor;
  }
}
