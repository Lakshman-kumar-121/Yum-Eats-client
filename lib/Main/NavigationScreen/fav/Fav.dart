import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/Main/NavigationScreen/fav/faccont.dart';
import 'package:screens/Main/NavigationScreen/fav/favload.dart';
import 'package:screens/main.dart';

class favu extends StatefulWidget {
   favu({Key? key}) : super(key: key);

  @override
  State<favu> createState() => _favuState();
}

class _favuState extends State<favu> {
   var controller = Get.put(FavrouteController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
            .collection("users")
            .doc(Cur_user_id)
            .snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return FavLoading();
        }
        return FutureBuilder(
          future: controller.getdata(snapshot.data?.data()),
          builder: (context, snapshot)  {
            if (snapshot.connectionState == ConnectionState.waiting) return FavLoading();
            return Scaffold(
              extendBody: true,
              body: Container(
                padding: EdgeInsets.only(top: 40 , bottom: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Favourite",
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                          ),
                          Icon(
                            Icons.favorite,
                            size: 40,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1.5,
                        color: Colors.black54,
                      ),
                      Obx(() {
                        if (controller.listlen.value == 0) return no_itm();
                        return Expanded(
                          child: 
                              ListView.builder(
                                  itemBuilder: (context, index) => item(index),
                                  itemCount: controller.listlen.value,
                                )) ;
                      },)
                     
                      
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }

  bool curcolor = false;

  no_itm() {
    return Expanded(
      child: Center(
        child: Text(
          "No fav items",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  item(index) {
    curcolor = !curcolor;
    return Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: (curcolor == false
            ? Color.fromARGB(255, 253, 234, 211)
            : Color.fromARGB(255, 207, 221, 255)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network("${controller.imagelist.elementAt(index)}"
             ,width: 120 ,height: 200, fit: BoxFit.cover,),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${controller.nameslist.elementAt(index)}",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
                  ),
                  Text("Rs  ${controller.pricelist.elementAt(index)} /-",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.addtocart(index);
                          },
                          child: Text(
                            "Add to cart",
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.3, 50)),
                        ),
                        IconButton(
                          onPressed: (){
                            controller.removefav(index);
                            },
                          icon:  Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 35,
                          ),
                        )
                      ])
                ],
              ),
            ),
          )
        ],
      ),
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric( vertical: 10),
    );
  }
}
