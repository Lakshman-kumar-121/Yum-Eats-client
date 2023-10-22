import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screens/Main/AccountScreens/camera/cameracont.dart';
import 'package:screens/main.dart';

class MyCamera extends StatefulWidget {
  const MyCamera({super.key});

  @override
  State<MyCamera> createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  var _cameracont = Get.put(MyCameraController());
  late CameraController controller;
  int ftcamera = 0;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[ftcamera], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        Get.snackbar("Error", e.code);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Color.fromARGB(255, 51, 51, 51),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 5,
              color: Colors.black,
              thickness: 5,
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                child: CameraPreview(controller),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.70),
            Divider(
              height: 5,
              color: Colors.black,
              thickness: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () async {
                        ftcamera = (ftcamera + 1) % 2;
                        controller = CameraController(
                            cameras[ftcamera], ResolutionPreset.max);
                        await controller.initialize().then((_) {
                          if (!mounted) {
                            return;
                          }
                          setState(() {});
                        }).catchError((Object e) {
                          if (e is CameraException) {
                            Get.snackbar("Error", e.code);
                          }
                        });
                      },
                      icon: Icon(
                        size: 35,
                        Icons.cameraswitch_outlined,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        controller.setFlashMode(
                            _cameracont.changeflash(_cameracont.x));
                        setState(() {});
                      },
                      icon: Obx(
                        () => Icon(
                          _cameracont.flicn.value,
                          size: 35,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 100,
          width: 100,
          child: IconButton(
            onPressed: () async {
              await _cameracont.tookimage(await controller.takePicture());
            },
            icon: Icon(
              Icons.camera,
              color: Colors.white,
              size: 70,
            ),
          ),
        ),
      ),
    );
  }
}
