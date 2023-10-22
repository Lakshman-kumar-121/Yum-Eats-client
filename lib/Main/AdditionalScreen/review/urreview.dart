import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AdditionalScreen/review/yourreviewcont.dart';

class YourReview extends StatelessWidget {
  YourReview({super.key});

  int rate = 0;

  var _yourReviewcont = Get.put(YourReviewController());

    
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _yourReviewcont.getYourData(),
      builder: (context, snapshot) {
        
      if(snapshot.connectionState == ConnectionState.waiting)return CircularProgressIndicator();
        return Scaffold(
          appBar: AppBar(
            
            leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },icon: Icon(
                Icons.swipe_left_alt,
              color: Colors.black,
              ),
              
            ),
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 253, 234, 211),
            title: Text(
              "Your Review",
              style: TextStyle(
                  fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Rating",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Divider(
                thickness: 1.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child:  ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => IconButton(
                      onPressed: () {
                        _yourReviewcont.rate.value = index;
                      },
                      icon: Obx(() {
                        if(index <= _yourReviewcont.rate.value){return Icon(
                        Icons.star,
                        size: 45,
                        color:  Colors.yellow,
                      ); }
                        return Icon(
                        Icons.star,
                        size: 45,
                        color: Colors.black26,
                      );
                      } , )),
                  itemCount: 5,
                ),
              ),
              Text(
                "Review",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "    ${_yourReviewcont.name}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 4,
                controller: _yourReviewcont.yourReviTCont,
                decoration: InputDecoration(
                    hintText: "Your review here",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black54),
                    filled: true,
                    fillColor: Colors.black12.withOpacity(0.06),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none)),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  _yourReviewcont.updateReview();
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                    backgroundColor: Color.fromARGB(255, 207, 221, 255),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
              )
            ]),
          ),
        );
      }
    );
  }
}
