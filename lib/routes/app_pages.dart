import 'package:get/get.dart';
import 'package:meme_generator_algostudio/features/detail_meme/binding_detail_meme.dart';
import 'package:meme_generator_algostudio/features/detail_meme/page_detail_meme.dart';
import 'package:meme_generator_algostudio/features/meme/page_meme.dart';
import 'package:meme_generator_algostudio/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.mainPage,
      page: () => const PageMeme(),
    ),
    GetPage(
      name: Routes.detail,
      page: () => PageDetailMeme(),
      binding: BindingDetailMeme(),
    ),
  ];
}
