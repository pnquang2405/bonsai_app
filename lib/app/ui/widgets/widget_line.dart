import 'package:flutter/material.dart';

class WidgetLine extends StatelessWidget {
  final Color? color;
  final double? thickness;
  final double? height;
  const WidgetLine({super.key, this.color, this.thickness, this.height});
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color ?? Colors.grey.shade200,
      thickness: thickness ?? 10,
    );
  }
}
