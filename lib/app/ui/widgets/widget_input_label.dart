// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class WidgetInputLabel extends StatelessWidget {
//   final FocusNode? node;
//   final FocusNode? next;
//   final TextEditingController? controller;
//   final String? hintText;
//   final String? prefixText;
//   final TextInputType? type;
//   final FormFieldValidator? validator;
//   final bool? hidePassword;
//   final bool? typeSelection;
//   final bool? readOnly;
//   final VoidCallback? onTap;
//   final VoidCallback? onTapWhenReadOnly;
//   final Function(String)? onChanged;
//   final Function(String)? onSubmitted;
//   final EdgeInsets? margin;
//   final int? maxLength;
//   final Widget? prefix;
//   final Color? fillColor;
//   final TextStyle? style;
//   final List<TextInputFormatter>? inputFormat;
//
//   const WidgetInputLabel(
//       {Key key,
//         this.onTap,
//         this.inputFormat,
//         this.maxLength,
//         this.prefixText,
//         this.style,
//         this.onTapWhenReadOnly,
//         this.fillColor,
//         this.margin,
//         this.onChanged,
//         this.onSubmitted,
//         this.controller,
//         this.type,
//         this.hidePassword,
//         this.hintText,
//         this.validator,
//         this.prefix,
//         this.readOnly = false,
//         this.typeSelection = false,
//         this.next,
//         this.node})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: margin ?? EdgeInsets.zero,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 4),
//         child: TextFormField(
//           focusNode: node,
//           textCapitalization: TextCapitalization.sentences,
//           controller: controller,
//           inputFormatters: inputFormat,
//           maxLength: maxLength,
//           onTap: readOnly! ? onTapWhenReadOnly : onTap,
//           readOnly: typeSelection || readOnly,
//           obscureText: hidePassword ?? false,
//           autofocus: false,
//           onChanged: onChanged,
//           onFieldSubmitted: (_) {
//             next?.requestFocus();
//             onSubmitted?.call(_);
//           },
//           keyboardType: type ?? TextInputType.text,
//           validator: validator,
//           style: style ?? AppStyles.mediumBold(context),
//           decoration: InputDecoration(
//               prefix: prefix,
//               counterText: '',
//               prefixText: prefixText,
//               suffixIcon: typeSelection
//                   ? Icon(
//                 Icons.keyboard_arrow_right_rounded,
//                 color: HexColor.fromHex("#828282"),
//               )
//                   : const SizedBox(),
//               labelText: hintText,
//               labelStyle: AppStyles.small(context).copyWith(color: HexColor.fromHex("#828282")),
//               filled: true,
//               fillColor: fillColor ?? AppColors.backgroundByTheme(context),
//               border: _borderInputDefault,
//               enabledBorder: _borderInput,
//               focusedBorder: _borderInput,
//               focusColor: HexColor.fromHex("#E2AE5D"),
//               contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12)),
//         ),
//       ),
//     );
//   }
//
//   InputBorder get _borderInputDefault => UnderlineInputBorder(
//     borderSide: BorderSide(color: AppColors.primary, width: 1.6),
//   );
//
//   InputBorder get _borderInput => UnderlineInputBorder(
//     borderSide: BorderSide(color: HexColor.fromHex("#E0E0E0"), width: 1.6),
//   );
// }
