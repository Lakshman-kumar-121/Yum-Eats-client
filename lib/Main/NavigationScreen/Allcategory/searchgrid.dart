import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/NavigationScreen/Allcategory/searchgridcont.dart';
import 'package:screens/Main/AdditionalScreen/Itemview/Itemview.dart';

class searchgrid extends StatelessWidget {
  final String selecteditem;
  searchgrid({super.key, required this.selecteditem});

  bool curcolor = true;

  var controller = Get.find<searchgridcontroller>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(controller.itemcount.value == 0){
        return no_item(context);
      }
      return GridView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1 / 1.5),
        itemCount: controller.itemcount.value,
        itemBuilder: (context, index) => GridTile(
              child: Material(
                child: InkWell(
                  onTap: () {
                    controller.itemview( controller.style_list ,index , selecteditem);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                    decoration: BoxDecoration(
                        color: curcolor
                            ? Color.fromARGB(255, 255, 238, 191)
                            : Color.fromARGB(255, 242, 255, 222),
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Material(
                              elevation: 5,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                    "${controller.style_list.values.elementAt(index)['img'].elementAt(0)}",
                                    fit: BoxFit.cover,
                                    height: 150),
                              ),
                            ),
                            Positioned(
                              left: 15,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                width: 60,
                                height: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Colors.amberAccent,
                                    ),
                                    Text(
 "${controller.rating.elementAt(index)}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "Rs ${controller.style_list.values.elementAt(index)['price']}/-",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          controller.style_list.keys.elementAt(index),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
    });

  }

  void color() {
    curcolor = !curcolor;
  }
   no_item(context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4),
      child: Text(
        "No item found :(",
        style: TextStyle(fontSize: 35),
      ),
    );
  }
  
}
