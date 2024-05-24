import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permit_app/views/const/color.dart';

class CardHomeScreen extends StatelessWidget {
  const CardHomeScreen({super.key, required this.text, required this.onTap});
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 200.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.h),
          color: kPrimaryColor
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.h,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
      ),
    );
  }
}
