part of 'my_health_history_screen.dart';

/// Format timeline date+time for display (e.g. "Today, 9:00 AM", "Mar 7, 4:30 PM").
String formatTimelineDisplayTime(String date, String time) {
  if (date.isEmpty) return time.isNotEmpty ? time : '';
  try {
    final datePart = DateTime.parse(date);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final d = DateTime(datePart.year, datePart.month, datePart.day);
    String timeStr = time;
    if (timeStr.length == 5 && timeStr.contains(':')) {
      final parts = timeStr.split(':');
      final h = int.tryParse(parts[0]) ?? 0;
      final m = int.tryParse(parts[1]) ?? 0;
      final dt = DateTime(datePart.year, datePart.month, datePart.day, h, m);
      timeStr = _formatTime(dt);
    }
    if (d == today) return 'Today, $timeStr';
    if (d == yesterday) return 'Yesterday, $timeStr';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final m = datePart.month >= 1 && datePart.month <= 12
        ? months[datePart.month - 1]
        : '';
    return '$m ${datePart.day}, $timeStr';
  } catch (_) {
    return date + (time.isNotEmpty ? ' $time' : '');
  }
}

String _formatTime(DateTime dt) {
  final h = dt.hour;
  final m = dt.minute;
  if (h == 0 && m == 0) return '12:00 AM';
  if (h == 12 && m == 0) return '12:00 PM';
  if (h < 12) return '${h == 0 ? 12 : h}:${m.toString().padLeft(2, '0')} AM';
  return '${h - 12}:${m.toString().padLeft(2, '0')} PM';
}

/// Format source for display (e.g. "Source: From Vitals App").
String formatSourceDisplay(String source) {
  if (source.isEmpty) return 'Source: Manual Entry';
  switch (source.toUpperCase()) {
    case 'VITALS':
      return 'Source: From Vitals App';
    case 'CONVERSATION':
      return 'Source: Voice Log';
    case 'MEDICATION':
      return 'Source: Medication';
    case 'ALERT':
      return 'Source: Alert';
    case 'SERVICE_REQUEST':
      return 'Source: Service Request';
    case 'MEMORY':
      return 'Source: Memory';
    default:
      return 'Source: $source';
  }
}

/// Whether severity/confidence is high or critical (for timeline dot color).
bool isHighSeverity(String confidence) {
  final u = confidence.toUpperCase();
  return u == 'HIGH' || u == 'CRITICAL';
}

/// Confidence label for timeline badge (also maps API severity).
String formatConfidenceLabel(String confidence) {
  switch (confidence.toUpperCase()) {
    case 'HIGH':
      return 'HIGH';
    case 'CRITICAL':
      return 'CRITICAL';
    case 'LOW':
      return 'LOW';
    default:
      return 'MEDIUM';
  }
}

/// Date marker label (e.g. "MAR 7, 2026").
String formatDateMarkerLabel(String date) {
  if (date.isEmpty) return '';
  try {
    final d = DateTime.parse(date);
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
    ];
    final m = d.month >= 1 && d.month <= 12 ? months[d.month - 1] : '';
    return '$m ${d.day}, ${d.year}';
  } catch (_) {
    return date;
  }
}

/// Icon for timeline entry by source. Requires material.dart (from screen).
IconData timelineIconForSource(String source) {
  switch (source.toUpperCase()) {
    case 'VITALS':
      return Icons.favorite_rounded;
    case 'CONVERSATION':
      return Icons.record_voice_over_rounded;
    default:
      return Icons.medical_services_rounded;
  }
}
