import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:screens/Main/LoginScreen/SignIn/reset.dart';
import 'package:screens/Main/LoginScreen/Signup/signupcont.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  var _SignupContoller = Get.put(SignupContoller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 255, 253),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Positioned(
                right: 0,
                child: Image.asset(
                  'assets/signup.png',
                  scale: .99,
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, right: 20, top: 60),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "SignUp",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        "Get amazing delicious food by joining us now!",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _SignupContoller.signup_name,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          labelText: "Username",
                          labelStyle: TextStyle(color: Colors.black),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.person_outline_outlined,
                                size: 30,
                              ))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    IntlPhoneField(
                      style: TextStyle(fontSize: 17),
                      controller: _SignupContoller.signup_number,
                      initialCountryCode: "+91",
                      dropdownTextStyle: TextStyle(fontSize: 17),
                      flagsButtonPadding: EdgeInsets.only(left: 15, bottom: 2),
                      initialValue: "+91",
                      showDropdownIcon: false,
                      onCountryChanged: ((country) {
                        
                        _SignupContoller.countrycode = country.dialCode;
                        
                        
                      }),
                      showCountryFlag: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        labelText: "Number",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              _SignupContoller.gotosignin();
                            },
                            child: Text(
                              "Signin",
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
                      height: 10,
                    ),
                    
                    SizedBox(
                      height: 130,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _SignupContoller.verifyPhoneNumner();
                      },
                      child: Text("Signup",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500)),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Color.fromARGB(255, 8, 77, 255),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 50)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                    Text(
                      "Creating an account means your are okay with our term and condition , Privacy policy",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
