import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marchant/ui/common/app_colors.dart';

import '../../common/app_text_style.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.height,
    this.width,
    this.hint = "hint",
    this.suffixTxt,
    required this.controller,
    this.disabled = false,
    this.onchange,
    this.inputType,
    this.stroke = true,
    this.prefixIcon,
    this.suffixIcon,
    this.hideText = false,
    this.onTap,
    this.darkText = true,
    this.validator,
    this.readOnly = false,
    this.error = false,
    this.onEditingComplete,
    this.focusNode,
    this.autoValiation = false,
    this.autofocus = false,
    this.inputFormatter,
    this.charLength = 40, // can be changed as needed
    this.centerText = false,
  });
  final double? height;
  final double? width;
  final String hint;
  final String? suffixTxt;
  final TextEditingController controller;
  final bool disabled;
  final Function(dynamic)? onchange;
  final TextInputType? inputType;
  final bool stroke;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hideText;
  final VoidCallback? onTap;
  final bool darkText;
  final Function(dynamic)? validator;
  final bool readOnly;
  final bool error;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final bool autoValiation;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatter;
  final int charLength;
  final bool centerText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50,
      child: TextFormField(
        textAlign: centerText ? TextAlign.center : TextAlign.left,
        maxLength: charLength,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        controller: controller,
        onTap: onTap,
        validator: (value) => validator!(value),
        keyboardType: inputType ?? TextInputType.text,
        onChanged: onchange,
        readOnly: readOnly,
        autofocus: false,
        inputFormatters: inputFormatter,
        textAlignVertical: TextAlignVertical.center,
        obscureText: hideText,
        style: darkText
            ? AppTextStyle.h4Normal
            : AppTextStyle.withColor(
                color: Colors.white,
                style: AppTextStyle.h4Normal,
              ),
        decoration: InputDecoration(
          counterText: '',
          enabled: !disabled,
          isDense: true,
          border: stroke
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 5,
                    color: error ? kcDanger : kcPrimaryColorDark,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                )
              : InputBorder.none,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: darkText
              ? AppTextStyle.withColor(
                  color: kcPrimaryColorDark.withOpacity(.5),
                  style: AppTextStyle.h4Normal,
                )
              : AppTextStyle.withColor(
                  color: Colors.white,
                  style: AppTextStyle.h4Normal,
                ),
          suffixText: suffixTxt ?? '',
          enabledBorder: stroke
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      width: error ? 1 : .5,
                      color: error ? kcDanger : kcPrimaryColorDark),
                  borderRadius: const BorderRadius.all(Radius.circular(5)))
              : InputBorder.none,
        ),
      ),
    );
  }
}
