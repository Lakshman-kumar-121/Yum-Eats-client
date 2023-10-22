import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AdditionalScreen/Itemview/itemviewcont.dart';

class Itemview extends StatelessWidget {
  var itemviewcontroller = Get.put(ItemviewController());
  var itemlist;
  final int index;
  


  Itemview({Key? key, required this.itemlist, required this.index })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return  FutureBuilder(
      future: itemviewcontroller.getData(itemlist, index ) ,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
        return SafeArea(
              child: Scaffold(
                floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
                floatingActionButton: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 35,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(bottom: 50, left: 15, right: 15),
                  child: 
                   Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.height * 0.9,
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  "${itemviewcontroller.images[0]}",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "${itemviewcontroller.itemname}",
                              style:
                                  TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Discription",
                              style:
                                  TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${itemviewcontroller.discriptin}",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 240, 240, 240),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rating",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        TextButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                minimumSize: Size(0, 0)),
                                            onPressed: () {
                                              itemviewcontroller.gotoreview();
                                            },
                                            child: Text(
                                              "See review",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            for (int x = 1; x <= 5; x++) generatestar(x)
                                          ],
                                        ),
                                        Text(
                                          "${itemviewcontroller.rating}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            Divider(),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Price",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "\u{20B9} ${itemviewcontroller.price} /-",
                                      style: TextStyle(
                                          fontSize: 30, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Add to fav",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          itemviewcontroller.changefav();
                                        },
                                        icon: Obx(() => Icon(
                                              Icons.favorite,
                                              size: 40,
                                              color: itemviewcontroller.isfav.value ==
                                                      true
                                                  ? Colors.redAccent
                                                  : Color.fromARGB(255, 190, 190, 190),
                                              shadows: [
                                                Shadow(
                                                  color: Colors.grey,
                                                  blurRadius: 7,
                                                  offset: Offset(1.5, 3),
                                                )
                                              ],
                                            )))
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            OutlinedButton(
                              onPressed: () async {
                                await itemviewcontroller.addtocart();
                               
                              },
                              child: Text(
                                "Add to cart",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              style: OutlinedButton.styleFrom(
                                  minimumSize: Size(double.maxFinite, 60),
                                  backgroundColor: Color.fromARGB(255, 8, 77, 255),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            OutlinedButton(
                              onPressed: () {
placeorder(context);
                              },
                              child: Text(
                                "Buy now",
                                style: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey.withOpacity(0.15),
                                  side: BorderSide(width: 1.5),
                                  minimumSize: Size(double.maxFinite, 60),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13))),
                            ),
                          ],
                        )
                      ,
                ),
              ),
            );
      }
    );
      
    
  }

  generatestar(int x) {
    if (x <= double.parse(itemviewcontroller.rating)) {
      return Icon(
        Icons.star,
        color: Colors.amberAccent,
        size: 32,
      );
    }
    if (x - 1 < double.parse(itemviewcontroller.rating) &&
        x > double.parse(itemviewcontroller.rating)) {
      return Icon(
        Icons.star_half,
        color: Colors.amberAccent,
        size: 32,
      );
    }
    return Icon(
      Icons.star,
      color: Color.fromARGB(255, 185, 185, 185),
      size: 32,
    );
  }
    placeorder(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height / 5,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deliver address",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Divider(),
                Text("${itemviewcontroller.add}",
                    style: TextStyle(fontWeight: FontWeight.w400)),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Net amount",
                        style: TextStyle(fontWeight: FontWeight.w400)),
                    Text("${itemviewcontroller.price + 10}/-",
                        style: TextStyle(fontWeight: FontWeight.w500))
                  ],
                )
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 3, 40)),
                    child: Text("Cancel")), 
                ElevatedButton(
                    onPressed: () {
                      itemviewcontroller.initPayment(amount: itemviewcontroller.price + 10 ,context: context ,);
// mycartcont.BuyNow();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 3, 40)),
                    child: Text("Pay"))
              ],
            )
          ],
        ),
      );
}
