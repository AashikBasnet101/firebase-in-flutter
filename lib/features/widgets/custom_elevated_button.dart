import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.child,
    this.foregroundColor,
    this.onPressed,
    this.width,
    this.height = 46, 
    final ButtonStyle? style,
  });

  final double? borderRadius;
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final void Function()? onPressed;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6),
          ),
          backgroundColor: backgroundColor ?? Colors.blue,
          foregroundColor: foregroundColor ?? Colors.white,
        ),
        onPressed: onPressed,
        child: Center(child: child),
      ),
    );
  }
}
