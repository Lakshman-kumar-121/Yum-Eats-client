import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AdditionalScreen/Orders/OrderCont.dart';
import 'package:screens/Main/AdditionalScreen/Orders/refcont.dart';

class Refrence extends StatelessWidget {
  Refrence({super.key});
  var _myrefCont = Get.put(RefrenceController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _myrefCont.getData(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Your orders"),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Orders"),
                      ListView.builder(
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _myrefCont.len,
                          itemBuilder: (context, index) =>
                              orderList(context, index , true)),
                      Text("Delivered"),
                      ListView.builder(
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _myrefCont.orlen,
                        itemBuilder: (context, index) =>
                              orderList(context, index , false)), 
                      
                    ],
                  ),
                )),
          );
        });
  }

  orderList(context, index , order) => InkWell(
        onTap: () {
          _myrefCont.gotoOrder(index , order);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 218, 255, 220),
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.13,
          child: Container(
              width: 150,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Id",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700),
                      ),
                      Text("Price",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600)),
                      Text("Date",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order ? "${_myrefCont.refId.elementAt(index)}" :"${_myrefCont.orrefId.elementAt(index)}"  ,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        
                        order ?  "${_myrefCont.price.elementAt(index)}" : "${_myrefCont.orprice.elementAt(index)}" ,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600)),
                      Text(
                        order ? 
                        "${_myrefCont.date.elementAt(index)}": "${_myrefCont.ordate.elementAt(index)}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600))
                    ],
                  )
                ],
              )),
        ),
      );
}
