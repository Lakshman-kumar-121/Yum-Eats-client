import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AdditionalScreen/Orders/OrderCont.dart';

class MyOder extends StatelessWidget {
   MyOder({super.key , required this.itmindex,  required this.data});
  int itmindex ;
  var data;
  var _myorderCont = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _myorderCont.getData(itmindex , data),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){return CircularProgressIndicator();}
      
        return Scaffold(
          appBar: AppBar(title: Text("Order")),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount:_myorderCont.len,
              
              itemBuilder: (context, index) => orderList(context , index)),
              
              ],
            )
          ),
        );
      }
    );
  }
  orderList(context , index)=> Container(
    margin: EdgeInsets.symmetric( vertical: 8),
    padding: EdgeInsets.symmetric(horizontal: 10),
    width: MediaQuery.of(context).size.width* 0.7,
    decoration: BoxDecoration(color: Color.fromARGB(255, 0, 138, 7),borderRadius: BorderRadius.circular(20)),
    height: MediaQuery.of(context).size.height * 0.2,
    child: Row(
      
      children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(020),
        child: Image.network("${_myorderCont.imglink.elementAt(index)}" ,
        height: MediaQuery.of(context).size.height * 0.17,
        width: 120,
        fit: BoxFit.cover,),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.55,
        padding: EdgeInsets.only(left: 10,right: 0 ,top: 15 ,bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, children: [Text("${_myorderCont.itmname.elementAt(index)}",
          
        style: TextStyle(fontSize: 28,fontWeight: FontWeight.w800),overflow: TextOverflow.ellipsis),
        Expanded(child: Text("")),
        Text("Category: ${_myorderCont.catename.elementAt(index)}" ,
        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)  ),Text("Qnty: ${_myorderCont.qnt.elementAt(index)}" ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600))
        ,],),
      )
    ],),
  );
}