import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
        required this.title,
        required this.icon,
        this.isPassword = false,
        required this.controller
      });

  final String title;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 20),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            obscuringCharacter: '●',
            autocorrect: false,
            decoration: InputDecoration(
                labelText: title,
                prefixIcon: Icon(icon),
                border: InputBorder.none),
          ),
        ));
  }
}