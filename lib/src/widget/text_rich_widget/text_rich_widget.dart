// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:greengrocer/src/config/custom_colors.dart';

class TextRichWidget extends StatelessWidget {
  final String primaryName;
  final String secundName;
  final double fontSize;
  final Color? colorPrimary;
  final Color? colorSecund;
  final FontWeight? fontWeightPrimary;
  final FontWeight? fontWeightSecund;
  const TextRichWidget({
    Key? key,
    required this.primaryName,
    required this.secundName,
    required this.fontSize,
    this.colorPrimary,
    this.colorSecund,
    this.fontWeightPrimary,
    this.fontWeightSecund,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: fontSize,
        ),
        children: [
          TextSpan(
            text: primaryName,
            style: TextStyle(
              color: colorPrimary ?? Colors.white,
              fontWeight: fontWeightPrimary ?? FontWeight.bold,
            ),
          ),
          TextSpan(
            text: secundName,
            style: TextStyle(
              color: colorSecund ?? CustomColors.customContrastColor,
              fontWeight: fontWeightSecund ?? FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
