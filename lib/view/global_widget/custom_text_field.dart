import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

TextFormField customTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String hintText,
  required Color fillColor,
  required Color borderColor,
  FocusNode? focusNode,
  TextCapitalization textCapitalization = TextCapitalization.words,
  TextInputType textInputType = TextInputType.text,
  bool obscureText = false,
  Widget? suffixIcon,
  TextInputAction textInputAction = TextInputAction.next,
  void Function(String)? onFieldSubmitted,
  int? maxLength,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
}) {
  return TextFormField(
    controller: controller,
    focusNode: focusNode,
    textCapitalization: textCapitalization,
    keyboardType: textInputType,
    obscureText: obscureText,
    cursorColor: borderColor,
    textInputAction: textInputAction,
    onFieldSubmitted: onFieldSubmitted,
    maxLength: maxLength,
    validator: validator,
    onSaved: onSaved,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      hintText: hintText,
      filled: true,
      fillColor: fillColor,
      contentPadding: EdgeInsets.symmetric(
          horizontal: context.percentWidth * 5,
          vertical: context.percentWidth * 3),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
    ),
  );
}
