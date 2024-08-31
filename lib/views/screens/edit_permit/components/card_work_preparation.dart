import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/edit_permit_controller.dart';
import 'package:permit_app/controllers/request_permit_controller.dart';

class CardWorkPreparation extends StatelessWidget {
  CardWorkPreparation({super.key, required this.title, required this.value});
  final String title;
  final bool value;
  final EditPermitController editPermitController = Get.put(EditPermitController());

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
              editPermitController.updateCheckboxValue(title, newValue ?? false);
            },
          ),
        ),
      ],
    );
  }
}
