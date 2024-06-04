import 'package:intl/intl.dart';

import '../common_imports/common_libs.dart';

TimeOfDay dateTimeToTimeOfDay(DateTime dateTime){
  DateTime currentDateTime = dateTime;
  // Convert DateTime to TimeOfDay
  TimeOfDay currentTime = TimeOfDay.fromDateTime(currentDateTime);
  return currentTime;
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  final formattedTime = DateFormat('hh:mm a').format(dateTime);
  return formattedTime;
}

DateTime timeOfDayToDateTime(TimeOfDay timeOfDay){
  final now = DateTime.now();
  final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  return dateTime;
}
String formatDateTime(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0');
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');
  return "$day:$hour:$minute";
}


String formatDateAndTime(DateTime dateTime) {
  return DateFormat('MMM, d, yyyy, hh:mm a').format(dateTime);
}

String dayAndTime(DateTime dateTime) {
  return DateFormat('EEEE, hh:mm a').format(dateTime);
}

String formatDayMonthYear(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

String getMonthName(DateTime dateTime) {
  return DateFormat('MMM').format(dateTime);
}
String formatDD(DateTime dateTime) {
  return DateFormat('MMMM, d, yyyy').format(dateTime);
}