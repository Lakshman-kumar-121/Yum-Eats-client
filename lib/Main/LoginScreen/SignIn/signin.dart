import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/LoginScreen/SignIn/reset.dart';
import 'package:screens/Main/LoginScreen/SignIn/signincont.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  var _signincontroller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 253, 234, 211),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: CustomPaint(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                    
                      padding: EdgeInsets.only(
                        left: 20,
                        top: MediaQuery.of(context).size.height * 0.1,
                      ),
                      child: Text(
                        "SignIn",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: ClipRRect( borderRadius: BorderRadius.circular(100) , child: Image.network('https://firebasestorage.googleapis.com/v0/b/restaurant-9bbe6.appspot.com/o/Accessory%2FAuthentication%2FRectangle%2070.jpg?alt=media&token=96bc5ce8-b093-4991-bfb8-62611cb5946c&_gl=1*fxxah7*_ga*OTgzMzg0NjQ4LjE2ODUzNjk2ODI.*_ga_CW55HF8NVT*MTY4NjEwODQ0OC4xMS4xLjE2ODYxMDg1OTQuMC4wLjA.')),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text("Welcome Back!",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w700))),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: _signincontroller.mailTController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon: Icon(
                              Icons.person_outline_outlined,
                              size: 30,
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Obx(() => TextField(
                        controller: _signincontroller.passTController,
                            obscureText: _signincontroller.passhidden.value,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      _signincontroller.changevisibility();
                                    },
                                    icon: Icon(
                                      _signincontroller.passhidden.value
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 30,
                                    ))),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                _signincontroller.gotosignup();
                              },
                              child: Text(
                                "Signup",
                                style: TextStyle(color: Colors.black),
                              )),
                          TextButton(
                              onPressed: () {
                                Get.to(Reset());
                              },
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _signincontroller.loginaccount();   
                        },
                        child: Text("Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Color.fromARGB(255, 180, 201, 255),
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Text(
                        "By continuing you accept our term and condition",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        onTap: () {
                          _signincontroller.gotopolicy();
                        },
                        child: Text(
                          "Privacy policy",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            size: Size(
                MediaQuery.of(context).size.width,
                (MediaQuery.of(context).size.width * 1.830078125)
                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: RPSCustomPainter(),
          ),
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 180, 201, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.3986873);
    path0.quadraticBezierTo(size.width * -0.0024414, size.height * 0.4656990,
        size.width * 0.0898438, size.height * 0.4655816);
    path0.cubicTo(
        size.width * 0.6540820,
        size.height * 0.4696585,
        size.width * 0.6532617,
        size.height * 0.4699146,
        size.width * 0.8837891,
        size.height * 0.4677161);
    path0.quadraticBezierTo(size.width * 0.9894141, size.height * 0.4668623,
        size.width, size.height * 0.4024226);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
