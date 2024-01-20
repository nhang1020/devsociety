import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatefulWidget {
  MyButton({
    super.key,
    this.isGradient,
    this.width,
    this.height,
    this.label,
    this.fontSize,
    this.icon,
    this.onPressed,
    this.radius,
    this.colors,
    this.boxShadows,
    this.textColor,
    this.subfixIcon,
    this.color,
    this.borderRadius,
    this.padding,
    this.border,
    this.duration,
    this.enabled,
    this.maxLines,
    this.textAlign,
    this.labelStyle,
  });
  bool? isGradient;
  double? width;
  double? height;
  String? label;
  double? fontSize;
  Widget? icon;
  Function()? onPressed;
  double? radius;
  List<Color>? colors;
  List<BoxShadow>? boxShadows;
  Color? textColor;
  Widget? subfixIcon;
  Color? color;
  BorderRadius? borderRadius;
  EdgeInsets? padding;
  Border? border;
  Duration? duration;
  bool? enabled;
  int? maxLines;
  TextAlign? textAlign;
  TextStyle? labelStyle;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      duration: widget.duration ?? Duration(seconds: 0),
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: widget.border,
        boxShadow: widget.boxShadows ?? [],
        borderRadius:
            widget.borderRadius ?? BorderRadius.circular(widget.radius ?? 10),
        gradient: LinearGradient(
            colors: widget.enabled != null && widget.enabled == false
                ? [myColor.withOpacity(.4), myColor.withOpacity(.4)]
                : (widget.isGradient != null && widget.isGradient == true
                    ? widget.colors ?? [myColor, myColor.withOpacity(.7)]
                    : [widget.color ?? myColor, widget.color ?? myColor])),
      ),
      child: Card(
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        elevation: 0,
        child: InkWell(
          onTap: widget.enabled != null && widget.enabled == false
              ? null
              : (widget.onPressed ?? null),
          child: Container(
            width: widget.width ?? 120,
            margin: widget.padding ??
                EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                widget.icon ?? Container(),
                SizedBox(width: widget.label != null ? 5 : 0),
                widget.label != null
                    ? Expanded(
                        child: Text(
                          "${widget.label}",
                          style: widget.labelStyle ??
                              TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: widget.fontSize ?? 14,
                                color: widget.textColor ??
                                    Theme.of(context).cardColor,
                              ),
                          textAlign: widget.textAlign ?? TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: widget.maxLines ?? 1,
                        ),
                      )
                    : SizedBox(),
                SizedBox(width: widget.label != null ? 5 : 0),
                widget.subfixIcon ?? SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
