import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) =>
    DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
