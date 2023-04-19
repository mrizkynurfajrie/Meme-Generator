import 'package:get/get.dart';
import 'package:meme_generator_algostudio/features/meme/api_meme.dart';
import 'package:meme_generator_algostudio/features/meme/controller_meme.dart';

class BindingMeme implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ControllerMeme(api: ApiMeme()));
  }
}