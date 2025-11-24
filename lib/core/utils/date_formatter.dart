import 'package:intl/intl.dart';

class DateFormatter {
  /// Formats a date string to a human-readable format
  /// Input: "2024-11-24T12:00:00.000Z" or similar ISO 8601 format
  /// Output: "24 Nov 2024" or relative format like "2 days ago"
  static String formatPostDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      // If less than a day ago, show relative time
      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          if (difference.inMinutes == 0) {
            return 'Just now';
          }
          return '${difference.inMinutes}m ago';
        }
        return '${difference.inHours}h ago';
      }
      // If less than a week ago, show days
      else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      }
      // Otherwise show formatted date
      else {
        return DateFormat('d MMM yyyy').format(date);
      }
    } catch (e) {
      // If parsing fails, return the original string
      return dateString;
    }
  }

  /// Formats a date to a simple format like "24 Nov 2024"
  static String formatSimpleDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('d MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
