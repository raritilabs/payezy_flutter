
import 'package:intl/intl.dart';

class DateUtilsFunction {
  static String formatEpochTime(int epochTime) {
    // Create a DateTime object using the epoch time
    DateTime date = DateTime.fromMillisecondsSinceEpoch(epochTime);

    // Define the desired date and time formats
    DateFormat dateFormat = DateFormat('MM/dd/yy');
    DateFormat timeFormat = DateFormat('HH:mm');

    // Format the date and time strings
    String dateStr = dateFormat.format(date);
    String timeStr = timeFormat.format(date);

    // Combine the date and time strings
    String formattedTime = '$dateStr $timeStr';

    // Return the formatted date and time string
    return formattedTime;
  }
}