import 'package:intl/intl.dart';

extension DateFormatyyyymmddMonthExtension on DateTime {
  String toDateyyyymmddFormattedString() => DateFormat('yyyy-MM-dd').format(this);
}

extension DateFormatddmmExtension on DateTime {
  String toDateddmmFormattedString() => DateFormat('dd MMM').format(this);
}

extension DateFormatddmmmyyyyExtension on DateTime {
  String toDateddmmmyyyyFormattedString() => DateFormat('dd MMM yyyy').format(this);
}

extension DateFormatyyyymmddMonthDayExtension on DateTime {
  String toFormattedDateDayTimeString() => DateFormat('d MMMM yyyy').format(this);
}