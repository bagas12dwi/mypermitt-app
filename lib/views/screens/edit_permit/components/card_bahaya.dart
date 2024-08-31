import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/edit_permit_controller.dart';

class CardBahaya extends StatelessWidget {
  CardBahaya({super.key, required this.title, required this.value, required this.screen, this.textController});
  final String title;
  final bool value;
  final String screen;
  final EditPermitController editPermitController = Get.put(EditPermitController());
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              if(title.startsWith('Lainnya:') && value)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: 'Lainnya',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Checkbox(
            value: value,
            onChanged: (newValue) {
              editPermitController.updatedCheckboxBahaya(screen, title, newValue ?? false);
            },
          ),
        ),
      ],
    );
  }
}
