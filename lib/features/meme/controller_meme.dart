import 'dart:developer';

import 'package:get/get.dart';
import 'package:meme_generator_algostudio/features/meme/api_meme.dart';
import 'package:meme_generator_algostudio/response/meme.dart';

class ControllerMeme extends GetxController {
  final ApiMeme api;
  ControllerMeme({required this.api});

  var loading = false.obs;
  var listMemeImg = List<MemeImages>.empty().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getMemeImages();
    super.onInit();
  }

  getMemeImages() async {
    loading.value = true;
    try {
      var r = await api.getMemeImages();
      log('data : $r');
      if (r['success'] == true) {
        var data = r["data"]["memes"];
        var listData =
            (data as List).map((data) => MemeImages.fromJson(data)).toList();
        if (listData.isNotEmpty) {
          listMemeImg.clear();
          listMemeImg.addAll(listData);
        }
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      print(e.toString());
    }
  }
}
