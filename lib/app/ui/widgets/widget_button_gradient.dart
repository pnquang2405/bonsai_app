import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../ui.dart';

class WidgetButtonGradient extends StatelessWidget {
  final String title;
  final VoidCallback? action;
  final bool? loading;
  final Color? colorTitle;
  final Color? colorLoading;
  final Alignment? alignmentStart;
  final Alignment? alignmentEnd;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final TextStyle? style;
  final Widget? child;
  final double? elevation;
  final double? radius;
  final Color? backgroundColor;
  final LinearGradient? gradient;
  final List<Color>? colors;

  const WidgetButtonGradient(
      {super.key,
      this.alignmentStart,
      this.style,
      this.radius = 80.0,
      this.loading = false,
      this.colorTitle,
      this.child,
      this.colors,
      this.alignmentEnd,
      this.colorLoading,
      this.gradient,
      this.backgroundColor,
      this.elevation,
      this.width = 60,
      this.height,
      this.padding,
      required this.title,
      required this.action});

  static const double defaultHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? defaultHeight,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation ?? 0),
          backgroundColor: MaterialStateProperty.all(backgroundColor ?? Colors.white),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!))),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(0.0),
          ),
        ),
        onPressed: loading! ? null : action ?? () {},
        child: Ink(
          decoration: BoxDecoration(
              gradient: gradient ??
                  LinearGradient(
                    colors: colors ??
                        [
                          AppColors.primary,
                          AppColors.primaryLight,
                        ],
                    begin: alignmentStart ?? Alignment.topLeft,
                    end: alignmentEnd ?? Alignment.bottomRight,
                  ),
              borderRadius: BorderRadius.circular(radius!)),
          child: Container(
            padding: padding ?? const EdgeInsets.only(bottom: 0.5),
            alignment: Alignment.center,
            child: !loading!
                ? child ??
                    Text(
                      title.tr,
                      textAlign: TextAlign.center,
                      style: style ??
                          AppTextStyles.medium.copyWith(
                            color: colorTitle ?? Colors.white,
                          ),
                    )
                : WidgetLoadingDot(
                    dotOneColor: colorLoading ?? Colors.white,
                    dotTwoColor: colorLoading ?? Colors.white,
                    dotThreeColor: colorLoading ?? Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}

enum DotType { square, circle, diamond, icon }

class WidgetLoadingDot extends StatefulWidget {
  final Color? dotOneColor;
  final Color? dotTwoColor;
  final Color? dotThreeColor;
  final Duration? duration;
  final DotType? dotType;
  final Icon? dotIcon;
  final double? size;

  const WidgetLoadingDot(
      {Key? key,
      this.dotOneColor = Colors.redAccent,
      this.dotTwoColor = Colors.redAccent,
      this.dotThreeColor = Colors.redAccent,
      this.duration = const Duration(milliseconds: 1000),
      this.dotType = DotType.circle,
      this.size = 10,
      this.dotIcon = const Icon(Icons.blur_on)})
      : super(key: key);

  @override
  _WidgetLoadingDotState createState() => _WidgetLoadingDotState();
}

class _WidgetLoadingDotState extends State<WidgetLoadingDot> with SingleTickerProviderStateMixin {
  Animation<double>? animation_1;
  Animation<double>? animation_2;
  Animation<double>? animation_3;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    animation_1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.0, 0.70),
      ),
    );

    animation_2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.1, 0.80),
      ),
    );

    animation_3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: const Interval(0.2, 0.90),
      ),
    );

    controller!.addListener(() {
      setState(() {
        //print(animation_1.value);
      });
    });

    controller!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    //print(animation_1.value <= 0.4 ? 2.5 * animation_1.value : (animation_1.value > 0.40 && animation_1.value <= 0.60) ? 1.0 : 2.5 - (2.5 * animation_1.value));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Opacity(
          opacity: (animation_1!.value <= 0.4
              ? 2.5 * animation_1!.value
              : (animation_1!.value > 0.40 && animation_1!.value <= 0.60)
                  ? 1.0
                  : 2.5 - (2.5 * animation_1!.value)),
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Dot(
              radius: widget.size,
              color: widget.dotOneColor,
              type: widget.dotType,
              icon: widget.dotIcon,
            ),
          ),
        ),
        Opacity(
          opacity: (animation_2!.value <= 0.4
              ? 2.5 * animation_2!.value
              : (animation_2!.value > 0.40 && animation_2!.value <= 0.60)
                  ? 1.0
                  : 2.5 - (2.5 * animation_2!.value)),
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Dot(
              radius: widget.size,
              color: widget.dotTwoColor,
              type: widget.dotType,
              icon: widget.dotIcon,
            ),
          ),
        ),
        Opacity(
          opacity: (animation_3!.value <= 0.4
              ? 2.5 * animation_3!.value
              : (animation_3!.value > 0.40 && animation_3!.value <= 0.60)
                  ? 1.0
                  : 2.5 - (2.5 * animation_3!.value)),
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Dot(
              radius: widget.size,
              color: widget.dotThreeColor,
              type: widget.dotType,
              icon: widget.dotIcon,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;
  final DotType? type;
  final Icon? icon;

  const Dot({Key? key, this.radius, this.color, this.type, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: type == DotType.icon
          ? Icon(
              icon!.icon,
              color: color,
              size: 1.3 * radius!,
            )
          : Transform.rotate(
              angle: type == DotType.diamond ? pi / 4 : 0.0,
              child: Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                    color: color,
                    shape: type == DotType.circle ? BoxShape.circle : BoxShape.rectangle),
              ),
            ),
    );
  }
}
