import 'package:flutter/material.dart';
import 'package:riverpod_freezed/theme/pallete.dart';

class Roundsmallbutton extends StatelessWidget {
  final String buttonText;
  final VoidCallback ontap;
  final Color backgroundColor;
  final Color fontColor;

  const Roundsmallbutton(
      {super.key,
      required this.buttonText,
      required this.ontap,
      this.backgroundColor = Pallete.whiteColor,
      this.fontColor = Pallete.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Chip(
        label: Text(
          buttonText,
          style: TextStyle(color: fontColor),
        ),
        backgroundColor: backgroundColor,
        labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      ),
    );
  }
}
