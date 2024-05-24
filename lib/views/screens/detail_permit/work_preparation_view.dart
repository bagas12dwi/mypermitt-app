import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';
import 'package:permit_app/models/work_preparation_model.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/rounded_button.dart';

class WorkPreparationView extends StatelessWidget {
  WorkPreparationView({super.key, required this.workPreparationModel, required this.onNextPressed});
  final List<WorkPreparationModel> workPreparationModel;
  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Work Preparation',
            style: TextStyle(
                fontSize: 16.h,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10.h,),
          Expanded(
            child: ListView.builder(
              itemCount: workPreparationModel.length,
              itemBuilder: (context, index) {
                final workPreparation = workPreparationModel[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.h,
                    vertical: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Text(workPreparation.pertanyaan),
                      ),
                      Expanded(
                        flex: 1,
                        child: workPreparation.value == 1
                            ? const Icon(Icons.check_circle)
                            : const Icon(Icons.circle_outlined),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Center(
              child: RoundedButton(
                  text: "Next",
                  press: onNextPressed
              )
          )
        ],
      ),
    );
  }
}
