import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
        final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: showshimmer(h * 0.06, w * 0.6, 20) ,backgroundColor: Colors.transparent, elevation: 0,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15 ,vertical: 20),
          child: Column(
            children: [showshimmer(h * 0.3, w * 0.98, 20) ,
            SizedBox(height: h *0.06,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [showshimmer(h * 0.08, w * 0.4, 15),
              showshimmer(h * 0.08, w * 0.4, 15)],),
            ),
            SizedBox(height: h * 0.02,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [showshimmer(h * 0.08, w * 0.4, 15),
              showshimmer(h * 0.08, w * 0.4, 15)],),
            ),
             SizedBox(height: h * 0.05,),
             showshimmer(h * 0.15, w * 0.9, 15)
             
           
            ],
          ),
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
