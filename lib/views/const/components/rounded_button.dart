import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permit_app/views/const/color.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final GestureTapCallback press;
  final Color color, textColor;
  const RoundedButton({
    super.key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontSize: 16.h,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButtonTwo extends StatelessWidget {
  final String text;
  final GestureTapCallback press;
  final Color color, textColor;
  const RoundedButtonTwo({
    super.key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontSize: 16.h,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButtonSmall extends StatelessWidget {
  final String text;
  final GestureTapCallback press;
  final Color color, textColor;
  const RoundedButtonSmall({
    super.key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.h),
      // width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.h),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w800
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButtonDialog extends StatelessWidget {
  const RoundedButtonDialog({super.key, required this.onPressed, this.backgroundColor = kPrimaryColor, this.textColor = kLight, required this.title});
  final Function() onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => backgroundColor),
            foregroundColor: MaterialStateColor.resolveWith((states) => textColor)
        ),
        child: Text(title)
    );
  }
}
