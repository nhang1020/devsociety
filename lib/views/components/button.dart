import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatefulWidget {
  const MyButton({
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
    this.enabled = true,
    this.maxLines,
    this.textAlign,
    this.labelStyle,
    this.enabledColor,
    this.enabledTextColor,
  });
  final bool? isGradient;
  final double? width;
  final double? height;
  final String? label;
  final double? fontSize;
  final Widget? icon;
  final Function()? onPressed;
  final double? radius;
  final List<Color>? colors;
  final List<BoxShadow>? boxShadows;
  final Color? textColor;
  final Widget? subfixIcon;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Border? border;
  final Duration? duration;
  final bool enabled;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextStyle? labelStyle;
  final Color? enabledColor;
  final Color? enabledTextColor;
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
            colors: !widget.enabled
                ? (widget.enabledColor != null
                    ? [widget.enabledColor!, widget.enabledColor!]
                    : [myColor.withOpacity(.4), myColor.withOpacity(.4)])
                : (widget.isGradient != null && widget.isGradient == true
                    ? widget.colors ?? [myColor, myColor.withOpacity(.7)]
                    : [widget.color ?? myColor, widget.color ?? myColor])),
      ),
      child: Card(
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        elevation: 0,
        child: InkWell(
          onTap: !widget.enabled ? null : (widget.onPressed ?? null),
          child: Container(
            width: widget.width,
            margin: widget.padding ??
                EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,

              children: [
                widget.icon ?? Container(),
                SizedBox(width: widget.label != null ? 5 : 0),
                widget.label != null
                    ? (widget.width != null
                        ? Expanded(
                            child: Text(
                              "${widget.label}",
                              style: widget.labelStyle ??
                                  TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: widget.fontSize ?? 14,
                                    color: widget.enabled
                                        ? (widget.textColor ?? Colors.white)
                                        : widget.enabledTextColor,
                                  ),
                              textAlign: widget.textAlign ?? TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: widget.maxLines ?? 1,
                            ),
                          )
                        : Text(
                            "${widget.label}",
                            style: widget.labelStyle ??
                                TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: widget.fontSize ?? 14,
                                  color: widget.enabled
                                      ? (widget.textColor ?? Colors.white)
                                      : widget.enabledTextColor,
                                ),
                            textAlign: widget.textAlign ?? TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: widget.maxLines ?? 1,
                          ))
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
