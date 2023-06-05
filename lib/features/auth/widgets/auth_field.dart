import 'package:flutter/material.dart';
import 'package:riverpod_freezed/theme/pallete.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassworfield;
  final String hintText;
  const AuthField(
      {super.key,
      required this.controller,
      this.isPassworfield = false,
      required this.hintText});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isHidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassworfield ? isHidePassword : false,
      cursorColor: Pallete.greyColor,
      decoration: InputDecoration(
          suffixIcon: widget.isPassworfield
              ? IconButton(
                  icon: Icon(
                      isHidePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() {
                    isHidePassword = !isHidePassword;
                  }),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Pallete.blueColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Pallete.greyColor, width: 1),
          ),
          contentPadding: const EdgeInsets.all(24),
          hintText: widget.hintText),
    );
  }
}
