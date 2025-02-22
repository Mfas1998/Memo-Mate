import 'package:intl/intl.dart';

class FormatDateTime {
  static String formattedDate(String milliseconds) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));

    String formattedDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day).toString();
    return formattedDate;
  }

  static String formattedTime(String milliseconds) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));

    String formattedTime = DateFormat('jm').format(dateTime).toString();
    return formattedTime;
  }

  static String dateTimeDifference(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} min ago';
    } else {
      return 'Just Now';
    }
  }

  static String formattedDateTime(String milliseconds) {
    String formattedDateTime = '';

    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));
    final today = DateTime.now();
    final yesterday = DateTime.now().add(const Duration(days: -1));

    final dateTimeFormatted =
        DateTime(dateTime.year, dateTime.month, dateTime.day);
    final todayFormatted = DateTime(today.year, today.month, today.day);
    final yesterdayFormatted =
        DateTime(yesterday.year, yesterday.month, yesterday.day);

    if (dateTimeFormatted == todayFormatted) {
      formattedDateTime =
          'Today ${DateFormat("jm").format(dateTime).toString()}';
    } else if (dateTimeFormatted == yesterdayFormatted) {
      formattedDateTime =
          'Yesterday ${DateFormat("jm").format(dateTime).toString()}';
    } else if (dateTime.year == today.year) {
      formattedDateTime = DateFormat.MMMd().format(dateTime).toString();
    } else {
      formattedDateTime = DateFormat.yMMMd().format(dateTime).toString();
    }
    return formattedDateTime;
  }
}
