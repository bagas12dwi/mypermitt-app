import 'package:flutter/material.dart';
import 'package:permit_app/views/const/color.dart';


class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? width;
  const TextFieldContainer({super.key, required this.child, this.color  = kLight, this.width = 0.8});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * width!,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}