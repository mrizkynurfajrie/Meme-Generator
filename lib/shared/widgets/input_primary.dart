import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meme_generator_algostudio/shared/constants/colors.dart';
import 'package:meme_generator_algostudio/shared/constants/styles.dart';

class InputPrimary extends StatefulWidget {
  final String hintText;
  final String? Function(String?)? validate;
  final Function() onTap;
  final Function(String?)? onChange;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FontStyle? hintFontStyle;
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final bool obsecureText;
  final bool? enable;
  final dynamic maxLines;
  final dynamic maxLenght;
  final String? initialValue;
  final double? boxWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final EdgeInsets? contentPadding;
  final Color? inputColor;
  final TextStyle? hintStyles;
  final InputBorder? inputBorder;

  const InputPrimary({
    Key? key,
    required this.hintText,
    this.validate,
    required this.onTap,
    this.onChange,
    this.prefixIcon,
    this.suffixIcon,
    this.hintFontStyle,
    this.label = '',
    this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.obsecureText = false,
    this.enable = true,
    this.maxLines = 1,
    this.maxLenght,
    this.initialValue,
    this.boxWidth,
    this.padding,
    this.margin,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.contentPadding,
    this.inputColor,
    this.hintStyles,
    this.inputBorder,
  }) : super(key: key);

  @override
  _InputPrimaryState createState() => _InputPrimaryState();
}

class _InputPrimaryState extends State<InputPrimary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.label != ''
            ? SizedBox(
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.neutral,
                  ),
                ),
              )
            : verticalSpace(0),
        Container(
          padding: widget.padding,
          margin: widget.margin,
          width: widget.boxWidth,
          child: TextFormField(
            initialValue: widget.initialValue,
            maxLines: widget.maxLines,
            maxLength: widget.maxLenght,
            enabled: widget.enable,
            enableInteractiveSelection: true,
            cursorColor: Theme.of(context).primaryColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: widget.onTap,
            onChanged: widget.onChange,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            obscureText: widget.obsecureText,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            validator: widget.validate,
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.neutral,
            ),
            decoration: inputDecoration(
              hintText: widget.hintText,
              hintStyles: widget.hintStyles,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              fontStyle: widget.hintFontStyle,
              enabledBorder: widget.enabledBorder,
              focusedBorder: widget.focusedBorder,
              errorBorder: widget.errorBorder,
              border: widget.inputBorder,
              contentPadding: widget.contentPadding,
              color: widget.inputColor ?? AppColor.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
