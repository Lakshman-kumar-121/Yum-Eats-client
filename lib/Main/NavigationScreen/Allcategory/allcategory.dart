import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/NavigationScreen/Allcategory/searchgrid.dart';
import 'package:screens/Main/NavigationScreen/Allcategory/searchgridcont.dart';

class searchscreen extends StatelessWidget {
  var style;
  searchscreen({super.key, required this.style});
  var controller = Get.put(searchgridcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: controller.getAllitems(style),
        builder: (context, snapshot)  {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: Column(
              children: [
                TextField(
                  controller: controller.searchTextController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                      hintText: "Search...",
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        iconSize: 30,
                        onPressed: () {

                          if(controller.searchTextController.text.isNotEmpty){
                            controller.getAllitems(controller.searchTextController.text.trim());
                          }
                          else{
                            controller.showemptysearch();
                          }
                        },
                      )),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: searchgrid(
                        selecteditem: "$style",
                      )),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
