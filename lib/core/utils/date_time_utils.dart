import 'package:intl/intl.dart';

/// Utility class for date and time formatting.
class DateTimeUtils {
  DateTimeUtils._();

  /// Formats a DateTime to a readable date string (e.g., "Dec 2, 2024").
  static String formatDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime);
  }

  /// Formats a DateTime to a readable time string (e.g., "2:30 PM").
  static String formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  /// Formats a DateTime to a full readable string (e.g., "Dec 2, 2024 at 2:30 PM").
  static String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)} at ${formatTime(dateTime)}';
  }

  /// Returns a relative time string (e.g., "Just now", "5 minutes ago", "Yesterday").
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 2) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days days ago';
    } else {
      return formatDate(dateTime);
    }
  }
}
