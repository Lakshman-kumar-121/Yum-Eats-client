import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AdditionalScreen/review/reviewload.dart';
import 'package:screens/Main/AdditionalScreen/review/yourreviewcont.dart';

class Review extends StatelessWidget {
  Review({super.key , required this.name , required this.category});
  var _yourReviewcont = Get.put(YourReviewController());
  var name;
  var category;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _yourReviewcont.getData(this.name , this.category ),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)return ReviewLoad();
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Review and rating"),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${name}",
                          style:
                              TextStyle(fontSize: 33, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Review",
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          height: 25,
                          thickness: 1.5,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _yourReviewcont.len.value,
                          itemBuilder: (context, index) => reviewList(index),)
                        
                       
                      ]),
                )),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.08),
              child: CustomPaint(
                size: Size(120, (120 * 0.4166666666666667).toDouble()),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        maximumSize: Size(130, 60),
                        minimumSize: Size(120, 59)),
                    onPressed: () {
                      _yourReviewcont.gotowriteRe();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Write",
                          style: TextStyle(fontSize: 25),
                        ),
                        Icon(Icons.edit)
                      ],
                    )),
                painter: RPSCustomPainter(),
              ),
            ));
      }
    );
  }
  reviewList(index) => Container(
    margin: EdgeInsets.symmetric(vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(255, 239, 239, 239)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${_yourReviewcont.nameList.elementAt(index)}",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              Divider(
                                thickness: 1.1,
                              ),
                              Text(
                                "${_yourReviewcont.disList.elementAt(index)}",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  calculateStar(_yourReviewcont.starList.elementAt(index)),
                                  Expanded(child: Text("")),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${_yourReviewcont.timeList.elementAt(index)}",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );

    calculateStar(num)=>
          Row(children: [ Icon(Icons.star , color: num< 1? Colors.grey:Colors.amberAccent ,size:27 ),
          Icon(Icons.star , color: num< 2?  Colors.grey:Colors.amberAccent,size:27),
          Icon(Icons.star , color: num< 3?  Colors.grey:Colors.amberAccent,size:27),
          Icon(Icons.star , color: num< 4?  Colors.grey:Colors.amberAccent,size:27),
          Icon(Icons.star , color: num< 5?  Colors.grey:Colors.amberAccent,size:27),
           ],);
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 91, 75, 139)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.2604545);
    path0.quadraticBezierTo(size.width * 0.0003167, size.height * 0.1372727,
        size.width * 0.0785417, size.height * 0.1359091);
    path0.cubicTo(
        size.width * 0.2880250,
        size.height * 0.1354545,
        size.width * 0.6980250,
        size.height * 0.1386364,
        size.width * 0.9070833,
        size.height * 0.1386364);
    path0.quadraticBezierTo(size.width * 1.0058333, size.height * 0.1480727,
        size.width, size.height * 0.3100000);
    path0.lineTo(size.width, size.height * 0.6275455);
    path0.quadraticBezierTo(size.width * 1.0010083, size.height * 0.7180364,
        size.width, size.height * 0.9378182);
    path0.quadraticBezierTo(size.width * 0.9823000, size.height * 1.0806364,
        size.width * 0.9038333, size.height * 0.8290545);
    path0.quadraticBezierTo(size.width * 0.2876771, size.height * 0.8389682,
        size.width * 0.0822917, size.height * 0.8422727);
    path0.quadraticBezierTo(size.width * -0.0018250, size.height * 0.8398909, 0,
        size.height * 0.7145455);
    path0.lineTo(0, size.height * 0.2604545);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
