import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoading extends StatelessWidget {
   HomeLoading({super.key});
  
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: showshimmer(h * 0.06, w * 0.5, 20),backgroundColor: Colors.transparent, elevation: 0,),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [showshimmer(h * 0.05 ,w * 0.4, 10) ,showshimmer(h * 0.05 ,w * 0.4, 10)],)
              ,SizedBox(height: h * 0.015,)
              ,showshimmer(h * 0.05 ,w * 0.4, 10),
              SizedBox(height: h * 0.015,),
              showshimmer(h * 0.2 ,w * 0.9, 40),
              SizedBox(height: h * 0.02,),
              showshimmer(h * 0.08 ,w * 0.9, 10),
               SizedBox(height: h * 0.04,),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [showshimmer(h * 0.04 ,w * 0.4, 0) ,showshimmer(h * 0.03 ,w * 0.2, 0)],),
               SizedBox(height: h * 0.04,),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [showshimmer(h * 0.22 ,w * 0.42, 40) ,showshimmer(h * 0.22 ,w * 0.42, 40)],)

          ],
        ),
      ),
    );
  }

  showshimmer(height , width , double brad)=>Shimmer.fromColors(
              child: Container(width: width,height: height,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(brad)
               ,color: Colors.white),), 
               baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!);
}