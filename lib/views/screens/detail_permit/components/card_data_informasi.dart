import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permit_app/views/const/color.dart';

class CardDataInformasi extends StatelessWidget {
  const CardDataInformasi({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.h,
          ),
        ),
        SizedBox(height: 5.h,),
        Container(
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(10.h)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 14.h
              ),
            ),
          ),
        )
      ],
    );
  }
}
