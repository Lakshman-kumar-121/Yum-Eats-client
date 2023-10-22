import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class ReviewLoad extends StatelessWidget {
  const ReviewLoad({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(appBar:AppBar(title: showshimmer(h * 0.06, w * 0.6, 20) ,backgroundColor: Colors.transparent, elevation: 0,),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          showshimmer(h * 0.07,w * 0.7, 15),
          SizedBox(height: h * 0.02,),
          showshimmer(h * 0.03,w * 0.3,5),
           Divider(
                            height: 25,
                            thickness: 1.5,
                          ),
                          SizedBox(height: 8,),
                          showshimmer(h * 0.15, w * 0.9,10),
                          SizedBox(height: 15,),
                          showshimmer(h * 0.15, w * 0.9,10),
                          SizedBox(height: 15,),
                          showshimmer(h * 0.15, w * 0.9,10),
                          SizedBox(height: 15,),
                          showshimmer(h * 0.15, w * 0.9,10)
        ],),
      ),
    ),);
  }
      showshimmer(height , width , double brad)=>Shimmer.fromColors(
              child: Container(width: width,height: height,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(brad)
               ,color: Colors.white),), 
               baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!);
}