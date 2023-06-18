import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_text_styles.dart';

class CameraApp extends StatefulWidget {
  CameraApp({super.key, required this.cameras, required this.onPost});
  final List<CameraDescription> cameras;
  final Function(String value) onPost;

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? controller;
  String? paths;
  bool capturing = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    ;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    if (paths != null) {
      setState(() {
        paths = null;
      });
    } else {
      setState(() {
        capturing = true;
      });
      final XFile xf = await controller!.takePicture();
      paths = xf.path;
      capturing = false;
      setState(() {});
    }
  }

  void setCameraResult() {
    // Get.back(result: paths);
    widget.onPost.call(paths!);
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          SizedBox(width: Get.width, height: Get.height, child: CameraPreview(controller!)),
          if (paths != null)
            Container(
              color: Colors.white,
              width: Get.width,
              height: Get.height,
              child: Image.file(
                File(paths!),
                height: Get.height,
                width: Get.width,
                fit: BoxFit.fill,
              ),
            ),

          Positioned(
            bottom: 0,
            child: Container(
                width: Get.width,
                height: 85,
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (paths == null)
                      _buildCircleButton(tt: 'Chụp', onTap: _captureImage)
                    else
                      _buildButton(tt: 'Chụp lại', onTap: _captureImage),
                    if (paths == null) const SizedBox() else const SizedBox(width: 15),
                    if (paths != null) _buildButton(tt: 'Gửi lên', onTap: setCameraResult),
                  ],
                )),
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Align(
          //       alignment: Alignment.bottomLeft,
          //       child: SizedBox(
          //         height: 90,
          //         child: ListView.builder(
          //             scrollDirection: Axis.horizontal,
          //             itemCount: paths.length,
          //             itemBuilder: (_, index) => Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
          //                 child: Image.file(
          //                   File(paths[index]),
          //                   height: 90,
          //                   width: 90,
          //                   fit: BoxFit.fill,
          //                 ))),
          //       ),
          //     ),
          //     Container(
          //         height: 60,
          //         alignment: Alignment.center,
          //         color: Colors.black,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             _buildButton(tt: "Chụp", onTap: _captureImage),
          //             const SizedBox(width: 15),
          //             _buildButton(tt: "Xong", onTap: setCameraResult),
          //           ],
          //         ))
          //   ],
          // ),
          if (capturing)
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }

  InkWell _buildCircleButton({VoidCallback? onTap, String? tt}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        height: 50,
        width: 50,
        child: Text(
          '',
          style: AppTextStyles.smallBold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  InkWell _buildButton({VoidCallback? onTap, String? tt}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(6))),
        alignment: Alignment.center,
        height: 40,
        width: 80,
        child: Text(
          tt ?? '',
          style: AppTextStyles.smallBold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
