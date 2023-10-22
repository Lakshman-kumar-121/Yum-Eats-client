import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:screens/Main/LoginScreen/Signup/signupcont.dart';

class OtpScreen extends StatelessWidget {
 OtpScreen({super.key});
  var _signnUpcont = Get.find<SignupContoller>();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 35,
              )),
          title: Text(
            "OTP",
            style:
                TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/otp.jpg",
                      width: MediaQuery.of(context).size.width * 0.8),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Verfication code",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("We have sent the verification code to your mobile number",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: 10,
                  ),
                  Text("+${_signnUpcont.countrycode} ${_signnUpcont.signup_number.text.trim()}",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 30,
                  ),
                 
        
        
                  PinCodeTextField(
                    showCursor: false,
                    hintCharacter: 'X',
                    cursorColor: Colors.black,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      inactiveColor: Colors.black,
                    ),
                    appContext: context,
                    length: 6,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _signnUpcont.smsCode = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Obx(() => Text("00:${_signnUpcont.stimer.value}")) , InkWell(onTap: (){
                      _signnUpcont.resndCode();
                       _signnUpcont.startTimer();
                    }, child: Obx(()=>_signnUpcont.resendCode() )) ,],)
                  
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color.fromARGB(255, 45, 145, 243),
              minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 55)),
          onPressed: () {
            _signnUpcont.verifyOtp();
          },
          child: Text("Submit",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
