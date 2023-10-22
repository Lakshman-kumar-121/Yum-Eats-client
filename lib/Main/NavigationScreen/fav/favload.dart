import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class FavLoading extends StatelessWidget {
  const FavLoading({super.key});

  @override
  Widget build(BuildContext context) {
        final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [showshimmer(h * 0.06, w * 0.6, 20),
      showshimmer(h * 0.06, w * 0.1, 10)],) ,backgroundColor: Colors.transparent, elevation: 0,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15 ,vertical: 20),
          child: Column(
            children: [showshimmer(h * 0.21, w * 0.98, 20) ,
            SizedBox(height: h *0.025,),
            showshimmer(h * 0.21, w * 0.98, 20),          SizedBox(height: h *0.025,),
            showshimmer(h * 0.21, w * 0.98, 20),          SizedBox(height: h *0.025,),
            showshimmer(h * 0.21, w * 0.98, 20)
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
