import 'package:flutter/material.dart';
import 'package:metafy_edge_detection/edge_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ProcessImage {
  Future<String> getImage(
      {@required String? scanTitle,
      @required String? cropTitle,
      @required String? cropBlackAndWhiteTitle}) async {
    String imagePath = '';

    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      return imagePath;
    }

    imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: scanTitle ?? 'Scanning',
        androidCropTitle: cropTitle ?? 'Crop',
        androidCropBlackWhiteTitle: cropBlackAndWhiteTitle ?? 'Black White',
        androidCropReset: 'Reset',
      );
      print('image path------->>>>> $imagePath');
      return imagePath;
    } catch (e) {
      print(e);
      return imagePath;
    }
  }
}
