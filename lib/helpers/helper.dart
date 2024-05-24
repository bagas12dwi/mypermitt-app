import 'dart:math';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Helper {
  static String getFirstText(String text) {
    String textFirst = text;
    List<String> output = textFirst.split(" ");
    return output[0];
  }

  static String convertToDate(String text) {
    String dateString = text; // Assuming text is in the format 'yyyy-MM-dd'
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime dateTime = inputFormat.parse(dateString);

    // Initialize date formatting for the Indonesian locale
    initializeDateFormatting('id', null);

    // Specify the desired locale (in this case, Indonesian)
    var formatter = DateFormat('dd MMMM yyyy', 'id');
    String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }

  static String convertDateToString(String text) {
    String dateString = text.substring(0, 19); // Extracting the date and time part
    DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = inputFormat.parse(dateString);

    // Initialize date formatting for the Indonesian locale
    initializeDateFormatting('id', null);

    // Specify the desired locale (in this case, Indonesian)
    var formatter = DateFormat('dd MMMM yyyy HH:mm', 'id');
    String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }

  static String generatePermitNumber(String text) {
    String dateString = text; // Assuming text is in the format 'yyyy-MM-dd'
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime dateTime = inputFormat.parse(dateString);

    // Initialize date formatting for the Indonesian locale
    initializeDateFormatting('id', null);

    // Specify the desired locale (in this case, Indonesian)
    var formatter = DateFormat('ddMMyyyy', 'id');
    String formattedDate = formatter.format(dateTime);
    String randomNumber = (Random().nextInt(90000) + 10000).toString();
    String permitNumber = 'PERMIT-${formattedDate}-${randomNumber}';

    return permitNumber;
  }
}