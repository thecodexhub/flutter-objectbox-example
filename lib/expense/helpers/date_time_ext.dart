extension DateTimeExt on DateTime {
  String get formattedTime {
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

    final ampm = hour >= 12 ? 'PM' : 'AM';
    final hrInt = hour % 12 == 0 ? 12 : (hour % 12);

    final hr = hrInt < 10 ? '0$hrInt' : '$hrInt';
    final mn = minute < 10 ? '0$minute' : '$minute';

    return '${months[month - 1]} $day, $hr:$mn $ampm';
  }
}
