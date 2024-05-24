import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/housekeeping_controller.dart';

class CardHousekeeping extends StatelessWidget {
  CardHousekeeping({super.key, required this.title, required this.value});
  final String title;
  final bool value;
  final HousekeepingController housekeepingController = Get.put(HousekeepingController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: Text(
            title,
          ),
        ),
        Expanded(
          flex: 1,
          child: Checkbox(
            value: value,
            onChanged: (newValue) {
              housekeepingController.updateCheckboxValue(title, newValue ?? false);
            },
          ),
        ),
      ],
    );
  }
}
