import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';

class WidgetSearchClear extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onSubmit;
  final TextEditingController controller;
  final VoidCallback? onSearch;
  final VoidCallback? onCancel;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final TextStyle? hintStyle;
  final double? radius;
  final double? height;
  final bool? readOnly;
  final bool? filled;
  final EdgeInsetsGeometry? contentPadding;

  const WidgetSearchClear({
    Key? key,
    required this.hint,
    this.onCancel,
    this.padding,
    this.readOnly = false,
    this.onSubmit,
    this.height,
    required this.controller,
    this.radius,
    this.hintStyle,
    this.onSearch,
    this.onChanged,
    this.contentPadding,
    this.filled = true,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (BuildContext context, TextEditingValue value, Widget? child) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 1.6),
              color: color!,
              borderRadius: BorderRadius.circular(45.r),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 100.h,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => onSubmit!(value.text),
                  child: Image.asset(
                    'assets/images/png/ic_search.png',
                    width: 50.h,
                    height: 50.h,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    autocorrect: false,
                    enableSuggestions: false,
                    onSubmitted: onSubmit,
                    onChanged: onChanged,
                    textInputAction: TextInputAction.search,
                    maxLines: 1,
                    // cursorHeight: 15.h,
                    autofocus: false,
                    controller: controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: filled,
                      enabled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                      focusedBorder: inputBorder,
                      enabledBorder: inputBorder,
                      border: inputBorder,
                      fillColor: color!,
                      hintStyle: AppTextStyles.small.copyWith(color: Colors.black38),
                      hintText: hint,
                    ),
                  ),
                ),
                if (value.text.isNotEmpty)
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: onCancel,
                    child: SizedBox(
                      width: 60.h,
                      height: 60.h,
                      child: Image.asset(
                        'assets/images/png/ic_remove.png',
                        fit: BoxFit.fill,
                        width: 60.h,
                        height: 60.h,
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          );
        });
  }

  InputBorder get inputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: color!,
        ),
        borderRadius: BorderRadius.circular(radius ?? 10),
      );
}
