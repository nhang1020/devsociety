import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.labelText,
      this.isPassword = false,
      this.prefixIcon,
      this.textInputAction = TextInputAction.next,
      this.onChanged,
      this.error,
      this.maxLenght,
      this.minLenght,
      this.isEmail = false,
      this.subfixIcon,
      this.keyboardType});
  final String? hintText;
  final TextEditingController? controller;
  final String? labelText;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? subfixIcon;
  final TextInputAction? textInputAction;
  final Function(String?)? onChanged;
  final String? error;
  final int? maxLenght;
  final int? minLenght;
  final bool isEmail;
  final TextInputType? keyboardType;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isViewPasword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword && isViewPasword,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: myColor.withOpacity(.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: myColor),
        ),
        filled: true,
        fillColor: myColor.withOpacity(.07),
        hintText: widget.hintText,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: TextStyle(color: myColor),
        labelText: widget.labelText,
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(.5),
        ),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: Colors.grey,
        suffixIcon: widget.isPassword && widget.subfixIcon == null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isViewPasword = !isViewPasword;
                  });
                },
                icon: !isViewPasword
                    ? Icon(
                        Icons.abc,
                        color: myColor,
                      )
                    : Icon(
                        Icons.password,
                        color: Colors.grey,
                      ),
              )
            : widget.subfixIcon,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.redAccent.shade100),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.redAccent.shade100),
        ),
        errorStyle: TextStyle(color: Colors.redAccent.shade100),
      ),
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.labelText} ${lang(context).isrequired.toLowerCase()}';
        }
        if (widget.isEmail &&
            !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                .hasMatch(value)) {
          return '${lang(context).invalid} email';
        }
        if (widget.error != null) {
          return widget.error;
        }
        if (widget.minLenght != null) {
          return value.length < widget.minLenght!
              ? "${widget.labelText} ${lang(context).least} ${widget.minLenght} ${lang(context).characters}"
              : null;
        }
        if (widget.maxLenght != null) {
          return value.length > widget.maxLenght!
              ? "${widget.labelText} ${lang(context).maximum} ${widget.maxLenght} ${lang(context).characters}"
              : null;
        }
        return null;
      },
      // onEditingComplete: () {},
    );
  }
}
