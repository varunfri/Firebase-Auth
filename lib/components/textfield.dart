import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final bool hide;
  final String name;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  const MyTextfield({
    super.key,
    required this.hide,
    required this.name,
    required this.controller,
    required this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: hide,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15, right: 10),
        hintText: name,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white)),
      ),
    );
  }
}
