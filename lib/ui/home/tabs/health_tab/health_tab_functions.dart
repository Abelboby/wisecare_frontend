part of 'health_tab_screen.dart';

/// Returns the first name (first word) from full name, or fallback if null/empty.
String _getFirstNameForGreeting(String? fullName, [String fallback = 'there']) {
  if (fullName == null || fullName.trim().isEmpty) return fallback;
  final trimmed = fullName.trim();
  final spaceIndex = trimmed.indexOf(' ');
  return spaceIndex < 0 ? trimmed : trimmed.substring(0, spaceIndex);
}
