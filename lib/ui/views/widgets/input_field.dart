import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/app_colors.dart';
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
    this.charLength = 30,
    this.extendable = false,
    this.maxLine,
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
  final bool extendable;
  final int? maxLine;
  final bool centerText;

  @override
  Widget build(BuildContext context) {
    return extendable
        ? expandableField()
        : SizedBox(
            width: width ?? MediaQuery.of(context).size.width,
            height: height ?? 50,
            child: TextFormField(
              textAlign: centerText ? TextAlign.center : TextAlign.left,
              maxLength: charLength,
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              validator: (value) => validator!(value),
              keyboardType: inputType ?? TextInputType.text,
              onChanged: onchange,
              onEditingComplete: onEditingComplete,
              focusNode: focusNode,
              autofocus: autofocus,
              textAlignVertical: TextAlignVertical.center,
              obscureText: hideText,
              inputFormatters: inputFormatter ?? [],
              style: darkText
                  ? AppTextStyle.h4Normal
                  : AppTextStyle.withColor(
                      color: Colors.white,
                      style: AppTextStyle.h4Normal,
                    ),
              decoration: InputDecoration(
                counterText: '',
                enabled: !disabled,
                focusColor: kcPrimaryColorDark,
                fillColor: kcPrimaryColorDark,
                border: stroke
                    ? const OutlineInputBorder(
                        gapPadding: 100,
                        borderSide:
                            BorderSide(width: 1, color: kcPrimaryColorDark),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
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
                            width: error ? 1.5 : .8,
                            color: error ? kcDanger : kcPrimaryColorDark),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)))
                    : InputBorder.none,
              ),
            ),
          );
  }

  Widget expandableField() {
    // wrap this widget with Expanded to use for multiple line text and
    // wrap it with Sized box with a specific height. recommended 50
    return TextFormField(
      maxLines: maxLine ?? (hideText ? 1 : null),
      minLines: hideText ? 1 : null,
      //expands: true,
      maxLength: charLength,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      validator: (value) => validator!(value),
      keyboardType: inputType ?? TextInputType.text,
      onChanged: onchange,
      autofocus: false,
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
                    width: 5, color: error ? Colors.red : kcPrimaryColorDark),
                borderRadius: const BorderRadius.all(Radius.circular(5)))
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
                    color: error ? Colors.red : kcPrimaryColorDark),
                borderRadius: const BorderRadius.all(Radius.circular(5)))
            : InputBorder.none,
      ),
    );
  }
}
