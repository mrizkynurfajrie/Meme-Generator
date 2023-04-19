import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meme_generator_algostudio/features/meme/controller_meme.dart';
import 'package:meme_generator_algostudio/response/meme.dart';
import 'package:meme_generator_algostudio/routes/app_routes.dart';
import 'package:meme_generator_algostudio/shared/constants/colors.dart';
import 'package:meme_generator_algostudio/shared/constants/styles.dart';
import 'package:meme_generator_algostudio/shared/widgets/loading_indicator.dart';
import 'package:meme_generator_algostudio/shared/widgets/page_decoration_top.dart';

class PageMeme extends GetView<ControllerMeme> {
  const PageMeme({super.key});

  @override
  Widget build(BuildContext context) {
    return PageDecorationTop(
      title: '',
      enableBack: false,
      backgroundColor: AppColor.neutral.shade200,
      toolbarColor: AppColor.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      center: const Center(
        child: Text(
          'Meme Generator',
          style: TextStyle(
            fontSize: 14,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => SizedBox(
                width: Get.width,
                height: Get.height,
                child: controller.loading.isFalse
                    ? RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(const Duration(seconds: 2));
                          controller.getMemeImages();
                        },
                        color: AppColor.primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.refresh_sharp,
                                  size: 24.h,
                                  color: AppColor.primaryColor,
                                ),
                                verticalSpace(6.h),
                                Text(
                                  'Swipe Down to Refresh',
                                  style: TextStyle(
                                    color: AppColor.neutral.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            verticalSpace(12.h),
                            Expanded(
                              child: GridView.builder(
                                itemCount: controller.listMemeImg.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemBuilder: (context, index) => CardItem(
                                  meme: controller.listMemeImg[index],
                                ),
                              ),
                            ),
                          ],
                        ))
                    : loadingIndicator(context)),
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.meme});

  final MemeImages meme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.detail, arguments: meme.url);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        height: 120,
        width: 80,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: AppColor.whiteColor,
          boxShadow: Shadows.shadowsUp,
        ),
        child: CachedNetworkImage(
          imageUrl: meme.url!,
          progressIndicatorBuilder: (context, url, progress) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 24,
            color: Colors.red,
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
