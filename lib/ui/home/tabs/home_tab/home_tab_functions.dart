part of 'home_tab_screen.dart';

/// Returns a time-based greeting (e.g. "Good Morning") for use with user name.
String _getGreetingPhrase() {
  final hour = DateTime.now().hour;
  if (hour < 12) return 'Good Morning';
  if (hour < 17) return 'Good Afternoon';
  return 'Good Evening';
}

/// Returns the first name (first word) from full name, or fallback if null/empty.
String _getFirstName(String? fullName, [String fallback = 'there']) {
  if (fullName == null || fullName.trim().isEmpty) return fallback;
  final trimmed = fullName.trim();
  final spaceIndex = trimmed.indexOf(' ');
  return spaceIndex < 0 ? trimmed : trimmed.substring(0, spaceIndex);
}
