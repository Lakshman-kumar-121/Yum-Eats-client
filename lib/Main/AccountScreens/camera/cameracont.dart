

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AccountScreens/camera/cameraclick.dart';

class MyCameraController extends GetxController {
  Rx flicn = Icons.flash_on.obs;
  int x = 0;
  var imgfile;
  changeflash(fmmode) {
    x = (x + 1) % 3;
    if (fmmode == 0) {
      flicn.value = Icons.flash_off;
      return FlashMode.off;
    } else if (fmmode == 1) {
      flicn.value = Icons.flash_auto;
      return FlashMode.auto;
    } else {
      flicn.value = Icons.flash_on;
      return FlashMode.always;
    }
  }

  tookimage(image) {
    imgfile = File(image.path);
    Get.to(CameraClick(image: imgfile));
  }

}
