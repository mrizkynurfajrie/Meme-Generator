import 'package:meme_generator_algostudio/framework/api.dart';

class ApiMeme {
  Future<dynamic> getMemeImages() async {
    var r = await Api().apiJsonGet('get_memes');

    return r;
  }
}
