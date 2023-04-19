import 'package:get/get.dart';
import 'package:meme_generator_algostudio/features/detail_meme/controller_detail_meme.dart';

class BindingDetailMeme implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ControllerDetailMeme());
  }
}