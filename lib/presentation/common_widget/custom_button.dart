import 'package:flutter/material.dart';

import '../const/app_const_dimensions.dart';
import '../const/styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Widget? buttonInnerWidget;
  final double? radius;
  final FontWeight fontWeight;
  final bool isBorder;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.transparent = false,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.color,
    this.borderColor,
    this.textColor,
    this.buttonInnerWidget,
    this.radius,
    this.fontWeight = FontWeight.w600,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).cardColor
          : transparent
          ? Colors.transparent
          : color ?? Theme.of(context).primaryColor,
      minimumSize: Size(
        width != null ? width! : 1170,
        height != null ? height! : 48,
      ),

      padding: EdgeInsets.zero,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          radius ?? Dimensions.RADIUS_DEFAULT + 2,
        ),
        side: isBorder
            ? BorderSide(color: borderColor?? Theme.of(context).dividerColor)
            : BorderSide.none,
      ),
    );

    return SizedBox(
      height: height != null ? height! : 56,
      child: Padding(
        padding: margin == null ? const EdgeInsets.all(0) : margin!,
        child: TextButton(
          onPressed: onPressed,
          style: flatButtonStyle,

          child:
              buttonInnerWidget ??
              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: subhead(context)!.copyWith(
                  color: onPressed == null
                      ? Theme.of(context).hintColor
                      : transparent
                      ? textColor ?? Theme.of(context).primaryColor
                      : textColor ?? Colors.white,
                  fontSize: fontSize??Dimensions.FONT_SIZE_DEFAULT,
                  fontWeight: fontWeight,
                ),
              ),
        ),
      ),
    );
  }
}
