import 'package:intl/intl.dart';

String formatWeight(dynamic value) {
  final formatter = NumberFormat('#,##0.#########');
  return formatter.format(value);
}