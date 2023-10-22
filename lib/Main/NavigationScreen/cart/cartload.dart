import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';


class CartLoading extends StatelessWidget {
  const CartLoading({super.key});

  @override
  Widget build(BuildContext context) {
        final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: showshimmer(h * 0.06, w * 0.6, 20) ,backgroundColor: Colors.transparent, elevation: 0,),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15 ,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [showshimmer(h * 0.21, w * 0.98, 20) ,
          SizedBox(height: h *0.025,),
          showshimmer(h * 0.21, w * 0.98, 20),   

          SizedBox(height: h*0.03,),
          showshimmer(h *0.04, w * 0.4, 10) ,
          SizedBox(height: h*0.01,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
             child:     showshimmer(h *0.13, w * 0.9, 10) ,
          ),
      
          SizedBox(height: h*0.01,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: showshimmer(h *0.07, w * 0.9, 10)  ,
          ),
                  
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
