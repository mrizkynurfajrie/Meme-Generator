import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:meme_generator_algostudio/features/detail_meme/controller_detail_meme.dart';
import 'package:meme_generator_algostudio/shared/constants/colors.dart';
import 'package:meme_generator_algostudio/shared/constants/styles.dart';
import 'package:meme_generator_algostudio/shared/widgets/button_primary.dart';
import 'package:meme_generator_algostudio/shared/widgets/page_decoration_top.dart';

class PageDetailMeme extends GetView<ControllerDetailMeme> {
  const PageDetailMeme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageDecorationTop(
      title: '',
      enableBack: true,
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
            () => Column(
              children: [
                SizedBox(
                  width: Get.width,
                  height: 300.h,
                  child: RepaintBoundary(
                    key: controller.boundaryKey,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        CachedNetworkImage(
                          imageUrl: controller.getImgUrl.value,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 48,
                          ),
                          fit: BoxFit.cover,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            controller.addLogoPreview.isNotEmpty
                                ? SizedBox(
                                    child: Image.file(
                                    File(controller.addLogoPreview.value),
                                    width: 120,
                                    height: 180,
                                    fit: BoxFit.contain,
                                  ))
                                : const SizedBox(),
                            const Spacer(),
                            controller.addedText.isNotEmpty
                                ? Container(
                                    color: AppColor.neutral.shade50
                                        .withOpacity(0.5),
                                    width: Get.width,
                                    child: Text(
                                      controller.addedText.value,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 48,
                                        color: AppColor.neutral,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                verticalSpace(12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ButtonPrimary(
                        label: 'Add Logo',
                        icon: Icons.photo,
                        height: 42,
                        onPressed: () async {
                          await controller.imgSourceSelector(context);
                          // controller.enableSaveButton(true);
                        },
                      ),
                    ),
                    horizontalSpace(16.w),
                    Expanded(
                      child: ButtonPrimary(
                        label: 'Add Text',
                        icon: Icons.text_fields,
                        height: 42,
                        onPressed: () async {
                          await controller.addTextPopUp();
                          // controller.enableSaveButton(true);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 8.h,
                    bottom: 8.h,
                  ),
                  child: Divider(
                    color: AppColor.neutral.shade300,
                    thickness: 1,
                  ),
                ),
                Column(
                  children: [
                    ButtonPrimary(
                      label: 'Save',
                      icon: Icons.save,
                      height: 42.h,
                      enable: controller.isEnableSave.isFalse ? false : true,
                      onPressed: () async {
                        await controller.captureImage();
                      },
                    ),
                    verticalSpace(12.h),
                    ButtonPrimary(
                      label: 'Share',
                      icon: Icons.share,
                      height: 42.h,
                      enable: controller.isEnableShare.isFalse ? false : true,
                      onPressed: () {
                        controller.shareSourceSelector(context);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
