import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextInput extends StatelessWidget {
  final String textString;
  final TextEditingController textController;
  final bool obscureText;
  final TextInputType? inputType;
  final dynamic validator;
  final bool? readOnly;
  const TextInput(
      {Key? key,
      required this.textString,
      required this.textController,
      required this.obscureText,
      required this.validator,
      this.inputType = TextInputType.text,
      this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      cursorColor: const Color(0xFF9b9b9b),
      validator: validator,
      controller: textController,
      keyboardType: inputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: HexColor(greyTextColor)),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: HexColor(greyTextColor))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: HexColor(greyTextColor))),
        labelText: textString,
        labelStyle: TextStyle(color: HexColor(greyTextColor)),
      ),
    );
  }
}
