import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator_algostudio/shared/constants/colors.dart';
import 'package:meme_generator_algostudio/shared/widgets/button_primary.dart';
import 'package:meme_generator_algostudio/shared/widgets/input_primary.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ControllerDetailMeme extends GetxController {
  var getImgUrl = ''.obs;
  var addLogoPreview = ''.obs;
  var addedText = ''.obs;
  TextEditingController addText = TextEditingController();
  final ImagePicker picker = ImagePicker();
  var isEnableSave = false.obs;
  var isEnableShare = false.obs;
  final GlobalKey boundaryKey = GlobalKey();

  @override
  void onInit() {
    // TODO: implement onInit
    getImgUrl.value = Get.arguments;
    super.onInit();
  }

  shareSourceSelector(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: SizedBox(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.facebook),
                    title: const Text('Share to Facebook'),
                    onTap: () {
                      onButtonTap(Share.facebook);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.social_distance),
                  title: const Text('Share to Twitter'),
                  onTap: () {
                    onButtonTap(Share.twitter);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ));
        });
  }

  captureImage() async {
    RenderRepaintBoundary boundary =
        boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    var directory = await getApplicationDocumentsDirectory();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);

    var firstPath = '${directory.path}/images';
    var filePathAndName = '${directory.path}/images/${DateTime.now()}.png';

    await Directory(firstPath).create(recursive: true);
    File file = File(filePathAndName);
    file.writeAsBytes(pngBytes);

    await askPermission();
    await GallerySaver.saveImage(file.path);

    Fluttertoast.showToast(msg: 'Image saved to your gallery');
    isEnableShare.value = true;
  }

  askPermission() async {
    await Permission.manageExternalStorage.request();
    await Permission.storage.request();
  }

  addTextPopUp() {
    addText.clear();
    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      barrierDismissible: true,
      title: 'Masukkan Text',
      content: Container(
        width: Get.width,
        color: AppColor.whiteColor,
        child: InputPrimary(
          hintText: 'Text',
          maxLines: 3,
          controller: addText,
          onTap: () {},
        ),
      ),
      confirm: ButtonPrimary(
        height: 42.h,
        onPressed: () async {
          addedText.value = addText.text;
          enableSaveButton(true);
          Get.back();
        },
        label: 'OK',
      ),
    );
  }

  imgSourceSelector(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: SizedBox(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      getFromCamera();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Image Gallery'),
                  onTap: () {
                    getFromFile();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ));
        });
  }

  Future<File> compressImage(XFile image) async {
    final dir = await path_provider.getTemporaryDirectory();
    var targetPath =
        "${dir.absolute.path}/temp-${DateTime.now().millisecondsSinceEpoch}.png";
    var compressFile = await FlutterImageCompress.compressAndGetFile(
      image.path,
      targetPath,
      quality: 70,
      format: CompressFormat.png,
    );
    return compressFile!;
  }

  getFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      var result = await compressImage(camImage);
      addLogoPreview.value = result.path;
      enableSaveButton(true);
    }
  }

  getFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      var result = await compressImage(fileImage);
      addLogoPreview.value = result.path;
      enableSaveButton(true);
    }
  }

  enableSaveButton(bool status) {
    if (addLogoPreview.value != "" && addedText.value != "") {
      isEnableSave.value = status;
    } else {
      isEnableSave.value = false;
    }
  }

  Future<void> onButtonTap(Share share) async {
    String msg = 'This meme so funny!';
    String url = getImgUrl.value;

    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case Share.facebook:
        response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
        break;

      case Share.twitter:
        response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
        break;
    }
    debugPrint(response);
  }
}

enum Share {
  facebook,
  twitter,
}
