import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/text_field_container.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class RoundedInputFieldAuth extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const RoundedInputFieldAuth({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.controller,
    this.keyboardType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kDark,
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const RoundedInputField({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.controller,
    this.keyboardType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: kPrimaryColor,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
    );
  }
}

class DateInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  const DateInputField({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(
              fontSize: 12.h,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 5.h,),
        TextFieldContainer(
          child: TextField(
            enabled: false,
            cursorColor: kPrimaryColor,
            controller: controller,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: kPrimaryColor,
              ),
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}

class DatePicker extends StatelessWidget {
  DatePicker({super.key});
  final DatePickerController controller = Get.put(DatePickerController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Obx(
              () => Text(
            controller.selectedDate.value.toString().split(' ')[0],
            style: TextStyle(
                fontSize: 16.h
            ),
          ),
        ),
        SizedBox(width: 10.h,),
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h))
          ),
          onPressed: () => controller.selectDate(context),
          child: Text(
            'Ganti Tanggal',
            style: TextStyle(
              fontSize: 10.h
            ),
          ),
        ),
      ],
    );
  }
}

class TimePicker extends StatelessWidget {
  TimePicker({super.key});
  final DatePickerController controller = Get.put(DatePickerController());


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Obx(
              () => Text(
                '${controller.selectedTime.value.hour}:${controller.selectedTime.value.minute}',            style: TextStyle(
                fontSize: 16.h
            ),
          ),
        ),
        SizedBox(width: 10.h,),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.h))
          ),
          onPressed: () => controller.selectTime(context),
          child: Text(
            'Ganti Jam',
            style: TextStyle(
                fontSize: 10.h
            ),
          ),
        ),
      ],
    );
  }
}



class DatePickerController extends GetxController {

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
    }
  }
}



class RoundedInputTextArea extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;

  const RoundedInputTextArea({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.keyboardType = TextInputType.text, required this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: kPrimaryColor,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class RoundedInputPassword extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? title;
  const RoundedInputPassword({
    super.key,
    this.onChanged,
    this.controller,
    this.title = 'Password'
  });

  @override
  State<RoundedInputPassword> createState() => _RoundedInputPasswordState();
}

class _RoundedInputPasswordState extends State<RoundedInputPassword> {
  RxBool obscuredText = true.obs;

  void changeObscuredText() {
    if (obscuredText.value == true) {
      obscuredText.value = false;
    } else {
      obscuredText.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFieldContainer(
        child: TextField(
          obscureText: obscuredText.value,
          onChanged: widget.onChanged,
          controller: widget.controller,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: widget.title,
            icon: const Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: IconButton(
                icon: const Icon(
                  Icons.visibility,
                  color: kPrimaryColor,
                ),
                onPressed: changeObscuredText),
            border: InputBorder.none,
          ),
        ),
      );
    });
  }
}