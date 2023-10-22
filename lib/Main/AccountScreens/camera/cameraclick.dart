import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AccountScreens/camera/cameraclickcont.dart';
import 'package:screens/Main/AccountScreens/camera/cameracont.dart';

class CameraClick extends StatelessWidget {
  var image;
  var _cameraclickcontroller = Get.put(CameraClickController());
  CameraClick({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Image view",
          ),
          backgroundColor: Colors.grey,
        ),
        backgroundColor: Colors.blueGrey,
        body: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height * 0.77 ,
          child: Column(
            children: [
              Divider(
                height: 5,
                color: Colors.black,
                thickness: 5,
              ),
              Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Image.file(  
                     File(image?.path ?? "")
                  , fit: BoxFit.contain),
              ),
              Divider(
                height: 5,
                color: Colors.black,
                thickness: 5,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: IconButton(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
            onPressed: () {
              _cameraclickcontroller.uploadtostorage(image);
            },
            icon: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 70,
            )),
      ),
    );
  }
}
