import 'package:flutter/material.dart';

class TextFieldConfig {
  final InputBorder? border;
  final Color borderColor;
  final double borderRadius;
  final Color cursorColor;
  final Color enabledBorderColor;
  final String? errorText;
  final Color errorColor;
  final bool? filled;
  final Color? fillColor;
  final Color focusedBorderColor;
  final double height;
  final String hintText;
  final Color hintColor;
  final IconData icon;
  final Color iconColor;
  final String? labelText;
  final Color labelColor;
  final Color labelErrorColor;
  final Color labelHintColor;
  final String prefix;
  final TextStyle? prefixStyle;
  final TextStyle? style;
  final Color textColor;
  final double widthBorder;
  final double widthEnabledBorder;
  final double widthFocusedBorder;

  TextFieldConfig({
    this.border,
    this.borderColor = Colors.black,
    this.borderRadius = 12.0,
    this.cursorColor = Colors.black,
    this.enabledBorderColor = Colors.black,
    this.errorText,
    this.errorColor = Colors.red,
    this.filled = false,
    this.fillColor = Colors.white,
    this.focusedBorderColor = Colors.black,
    this.height = 15.0,
    this.hintText = '',
    this.hintColor = Colors.black,
    this.icon = Icons.calendar_month_rounded,
    this.iconColor = Colors.black,
    this.labelText,
    this.labelColor = Colors.black,
    this.labelErrorColor = Colors.red,
    this.labelHintColor = Colors.black,
    this.prefix = '',
    this.prefixStyle = const TextStyle(fontSize: 20, color: Colors.black),
    this.style = const TextStyle(color: Colors.black),
    this.textColor = Colors.black,
    this.widthBorder = 1.0,
    this.widthEnabledBorder = 1.0,
    this.widthFocusedBorder = 1.0,
  });
}
