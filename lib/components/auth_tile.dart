import 'package:flutter/material.dart';

class Authtile extends StatelessWidget {
  final String imagepath;
  final Function()? onTap;

  const Authtile({super.key, required this.imagepath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: 50,
        width: 50,
        child: Image.asset(imagepath),
      ),
    );
  }
}
