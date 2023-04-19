import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meme_generator_algostudio/shared/constants/colors.dart';

Widget verticalSpace(double v) {
  return SizedBox(height: v);
}

Widget horizontalSpace(double v) {
  return SizedBox(width: v);
}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.13),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 5)),
      ];
  static List<BoxShadow> get small => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1)),
      ];

  static List<BoxShadow> get menu => [
        BoxShadow(
            color: const Color(0xFF000000).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4)),
      ];
  static List<BoxShadow> get none => [
        BoxShadow(
            color: AppColor.neutral.shade50,
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 0)),
      ];

  static List<BoxShadow> get shadowsUp => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(-1, 0)),
      ];
}

class Corners {
  static double sm = 3.w;
  static BorderRadius smBorder = BorderRadius.all(smRadius);
  static Radius smRadius = Radius.circular(sm);

  static double med = 5.w;
  static BorderRadius medBorder = BorderRadius.all(medRadius);
  static Radius medRadius = Radius.circular(med);

  static double lg = 8.w;
  static BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static Radius lgRadius = Radius.circular(lg);

  static double lgOrderHistory = 12.w;
  static BorderRadius lgOrderHistoryBorder =
      BorderRadius.all(lgOrderHistoryRadius);
  static Radius lgOrderHistoryRadius = Radius.circular(lgOrderHistory);

  static double xl = 16.w;
  static BorderRadius xlBorder = BorderRadius.all(xlRadius);
  static Radius xlRadius = Radius.circular(xl);

  static double xxl = 24.w;
  static BorderRadius xxlBorder = BorderRadius.all(xxlRadius);
  static Radius xxlRadius = Radius.circular(xxl);
}

class Strokes {
  static const double xthin = 0.7;
  static const double thin = 1;
  static const double med = 2;
  static const double thick = 4;
}

class Sizes {
  static double get xs => 8.w;
  static double get sm => 12.w;
  static double get smmed => 16.w;
  static double get med => 20.w;
  static double get lg => 32.w;
  static double get xl => 48.w;
  static double get xxl => 80.w;
}

class BorderStyles {
  static Border borderGrey =
      Border.all(color: Colors.grey.withOpacity(0.4), width: 1.5);

  static OutlineInputBorder enableTextField = OutlineInputBorder(
    borderSide:
        BorderSide(color: AppColor.neutral.shade300, width: Strokes.xthin),
    borderRadius: Corners.lgBorder,
  );

  static OutlineInputBorder focusTextField = OutlineInputBorder(
    borderSide:
        const BorderSide(color: AppColor.primaryColor, width: Strokes.thin),
    borderRadius: Corners.lgBorder,
  );

  static OutlineInputBorder disableTextField = OutlineInputBorder(
    borderSide:
        BorderSide(color: AppColor.neutral.shade300, width: Strokes.xthin),
    borderRadius: Corners.lgBorder,
  );

  static OutlineInputBorder registerOutline = OutlineInputBorder(
    borderSide:
        BorderSide(color: AppColor.neutral.shade100, width: Strokes.xthin),
    borderRadius: BorderRadius.all(Radius.circular(12.w)),
  );

  static OutlineInputBorder errorTextField = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: Strokes.thin),
    borderRadius: Corners.lgBorder,
  );
}

InputDecoration inputDecoration({
  required String hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  FontStyle? fontStyle,
  InputBorder? enabledBorder,
  InputBorder? focusedBorder,
  InputBorder? errorBorder,
  EdgeInsets? contentPadding,
  Color? color,
  TextStyle? hintStyles,
  InputBorder? border,
}) {
  return InputDecoration(
    isDense: true,
    filled: true,
    fillColor: color ?? Colors.white,
    contentPadding:
        contentPadding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    hintText: hintText,
    border: border ?? BorderStyles.disableTextField,
    focusedBorder: focusedBorder ?? BorderStyles.focusTextField,
    enabledBorder: enabledBorder ?? BorderStyles.enableTextField,
    errorBorder: errorBorder ?? BorderStyles.errorTextField,
    disabledBorder: BorderStyles.disableTextField,
    errorMaxLines: 5,
    prefixIcon: prefixIcon,
    prefixIconConstraints:
        BoxConstraints(minHeight: Sizes.lg, minWidth: Sizes.lg),
    suffixIconConstraints:
        BoxConstraints(minHeight: Sizes.lg, minWidth: Sizes.lg),
    suffixIcon: suffixIcon,
    hintStyle: hintStyles ??
        TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColor.neutral.shade400,
          fontStyle: fontStyle ?? FontStyle.normal,
        ),
  );
}
