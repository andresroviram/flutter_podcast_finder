/// Formats a timestamp in milliseconds to a date string like "Dec 16, 2023"
String formatDate(int timestampMs) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestampMs);
  final months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

/// Formats duration in seconds to a string like "60 min" or "1h 30m"
String formatDuration(int durationInSeconds) {
  final hours = durationInSeconds ~/ 3600;
  final minutes = (durationInSeconds % 3600) ~/ 60;

  if (hours > 0) {
    if (minutes > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${hours}h';
  }
  return '$minutes min';
}
