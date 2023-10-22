import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final ImageUrl;
  const ImageView(this.ImageUrl, {Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;

  TapDownDetails? tapDownDetails;

  late AnimationController animationController;
  Animation<Matrix4>? animation;
  @override
  void initState() {
    super.initState();
    controller = TransformationController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            controller.value = animation!.value;
          });
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onDoubleTapDown: (details) => tapDownDetails = details,
          onDoubleTap: () {
            final position = tapDownDetails!.localPosition;
            final double scale = 4;
            final x = -position.dx * (scale - 1);
            final y = -position.dy * (scale - 1);

            final zoomed = Matrix4.identity()
              ..translate(x, y)
              ..scale(scale);
            final end =
                controller.value.isIdentity() ? zoomed : Matrix4.identity();
            animation = Matrix4Tween(begin: controller.value, end: end).animate(
                CurveTween(curve: Curves.easeOut).animate(animationController));
            animationController.forward(from: 0);
          },
          child: InteractiveViewer(
            transformationController: controller,
            maxScale: 4,
            clipBehavior: Clip.none,
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(widget.ImageUrl),
                  )),
            ),
          ),
        ),
      );
    
  }

}
