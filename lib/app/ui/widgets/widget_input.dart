import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class WidgetInput extends StatefulWidget {
  final String? icons;
  final BuildContext? context;
  final bool readOnly;
  final Color? colorBorder;
  final TextEditingController? controller;
  final String? hint;
  final bool obscureText;
  final double? cursorHeight;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmit;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final VoidCallback? onEditing;
  final VoidCallback? onTap;
  final bool isPassword;

  final OutlineInputBorder? outlineInputBorder;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final bool? filled;
  final bool? autoValidate;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldValidator<String>? validator;
  final Color? cursorColor;
  final int? maxLines;
  final int? minLines;
  final bool? expands;
  final double? heightSuffix;
  final double? radius;
  final Widget? prefixIcon;
  final String? labelText;
  final ValueChanged<String>? onChange;
  final Color? fillColor;
  final TextStyle? errorStyle;
  final double? heightPrefix;
  final double widthPrefix;

  WidgetInput(
      {Key? key,
      this.icons,
      this.widthPrefix = 0,
      this.context,
      this.heightSuffix,
      this.readOnly = false,
      this.controller,
      this.onChange,
      this.labelText,
      this.maxLines = 1,
      this.colorBorder,
      this.minLines,
      this.radius,
      this.errorStyle,
      this.expands = false,
      this.heightPrefix,
      this.cursorColor,
      this.filled,
      this.autoValidate,
      this.prefixIcon,
      this.onTap,
      this.cursorHeight,
      this.contentPadding,
      this.suffixIcon,
      this.hint,
      this.outlineInputBorder,
      this.obscureText = false,
      this.focusNode,
      this.fillColor,
      this.hintStyle,
      this.style,
      this.onSubmit,
      this.textInputAction,
      this.inputType,
      this.onEditing,
      this.isPassword = false,
      this.validator})
      : super(key: key);

  @override
  _WidgetInputState createState() => _WidgetInputState();
}

class _WidgetInputState extends State<WidgetInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      onTap: widget.onTap,
      obscureText: widget.obscureText,
      onFieldSubmitted: widget.onSubmit,
      onEditingComplete: widget.onEditing,
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.done,
      readOnly: widget.readOnly,
      cursorHeight: widget.cursorHeight,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      cursorColor: widget.cursorColor,
      onChanged: widget.onChange,
      autovalidateMode: AutovalidateMode.disabled,
      controller: widget.controller,
      keyboardType: widget.inputType,
      validator: widget.validator,
      style: widget.style,
      expands: widget.expands!,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconConstraints: widget.heightSuffix != null
            ? BoxConstraints(
                maxHeight: widget.heightSuffix!,
                minHeight: widget.heightSuffix!,
              )
            : null,
        errorStyle: widget.errorStyle,
        suffixIcon: widget.suffixIcon,
        filled: widget.filled ?? true,
        prefixIconConstraints: widget.heightPrefix != null
            ? BoxConstraints(
                minWidth: widget.widthPrefix,
                maxWidth: widget.widthPrefix,
                maxHeight: widget.heightPrefix!,
                minHeight: widget.heightPrefix!,
              )
            : null,
        isCollapsed: true,
        isDense: true,
        enabledBorder: _buildBorderTextField(),
        // errorBorder: _buildBorderTextField(),
        focusedBorder: _buildBorderTextField(),
        // focusedErrorBorder: _buildBorderTextField(),
        // disabledBorder: _buildBorderTextField(),
        prefixIcon: widget.prefixIcon,
        fillColor: widget.fillColor ?? Colors.transparent,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
        hintText: widget.hint,
        labelText: widget.labelText ?? null,
        labelStyle: AppTextStyles.small.copyWith(color: AppColors.textC4),
        hintStyle: widget.hintStyle ?? AppTextStyles.small.copyWith(color: AppColors.textC4),
        border:
            widget.outlineInputBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  OutlineInputBorder _buildBorderTextField() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 5)),
        borderSide: BorderSide(color: widget.colorBorder ?? AppColors.textC4, width: 1.0));
  }
}
