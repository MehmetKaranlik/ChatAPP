import 'package:chat_app_example/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFieldUsername extends StatelessWidget {
  final String hintText;
  final double fontSize;
  final bool obscure;
  final TextEditingController controller;

  const CustomTextFieldUsername({
    Key? key,
    required this.hintText,
    required this.fontSize,
    required this.obscure,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        return value!.isEmpty || value.length < 4
            ? "Please provide username!"
            : null;
      },
      style: const TextStyle(
        color: Colors.white,
      ),
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class CustomTextFieldEmail extends StatelessWidget {
  final String hintText;
  final double fontSize;
  final bool obscure;
  final TextEditingController controller;

  const CustomTextFieldEmail({
    Key? key,
    required this.hintText,
    required this.fontSize,
    required this.obscure,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        if (!GetUtils.isEmail(value.toString())) {
          return "Email is not valid";
        } else {
          return null;
        }
      },
      style: const TextStyle(
        color: Colors.white,
      ),
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class CustomTextFieldPassword extends StatelessWidget {
  final String hintText;
  final double fontSize;
  final bool obscure;
  final TextEditingController controller;

  const CustomTextFieldPassword({
    Key? key,
    required this.hintText,
    required this.fontSize,
    required this.obscure,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        return value!.length > 6 ? null : " Please provide a valid password";
      },
      style: const TextStyle(
        color: Colors.white,
      ),
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class CustomTextFieldPasswordConfirm extends StatelessWidget {
  final String hintText;
  final double fontSize;
  final bool obscure;
  final TextEditingController controller;

  const CustomTextFieldPasswordConfirm({
    Key? key,
    required this.hintText,
    required this.fontSize,
    required this.obscure,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        return value == controller.text ? null : "Passwords does not match";
      },
      style: const TextStyle(
        color: Colors.white,
      ),
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
