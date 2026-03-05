part of 'meds_tab_screen.dart';

/// Classification of a dose section relative to the current device time.
enum _SectionPhase {
  /// Time slot has already passed (e.g. Morning when it's now afternoon).
  past,
  /// Time slot is active right now — show the featured card.
  current,
  /// Time slot hasn't arrived yet — show dimmed, no featured card.
  upcoming,
}

/// Time-slot ranges in minutes from midnight.
///   Morning:   06:00 – 11:59  (360  – 719)
///   Afternoon: 12:00 – 16:59  (720  – 1019)
///   Evening:   17:00 – 20:59  (1020 – 1259)
///   Night:     21:00 – 23:59  (1260 – 1439)
_SectionPhase _computePhase(String label) {
  final now = DateTime.now();
  final minutesNow = now.hour * 60 + now.minute;
  final lower = label.toLowerCase();

  int start;
  int end;

  if (lower.contains('morning')) {
    start = 6 * 60;
    end = 12 * 60 - 1;
  } else if (lower.contains('afternoon')) {
    start = 12 * 60;
    end = 17 * 60 - 1;
  } else if (lower.contains('evening')) {
    start = 17 * 60;
    end = 21 * 60 - 1;
  } else if (lower.contains('night')) {
    start = 21 * 60;
    end = 24 * 60 - 1;
  } else {
    // Unknown label — fall back to "upcoming" so it shows dimmed.
    return _SectionPhase.upcoming;
  }

  if (minutesNow > end) return _SectionPhase.past;
  if (minutesNow >= start) return _SectionPhase.current;
  return _SectionPhase.upcoming;
}

/// Returns the index of the first untaken medication in [meds] when the
/// section is [_SectionPhase.current], or -1 otherwise (no featured card).
int _featuredMedIndex(_SectionPhase phase, List<MedicationModel> meds) {
  if (phase != _SectionPhase.current) return -1;
  for (int i = 0; i < meds.length; i++) {
    if (!meds[i].isTakenToday) return i;
  }
  return -1; // All taken in current section — no featured card needed.
}

/// Icon + color for each dose section header, driven by the section label.
({IconData icon, Color color}) _sectionIconStyle(String label) {
  final lower = label.toLowerCase();
  if (lower.contains('morning')) {
    return (icon: Icons.wb_sunny_rounded, color: _MedsColors.morningSunIcon);
  }
  if (lower.contains('afternoon')) {
    return (icon: Icons.wb_sunny_rounded, color: _MedsColors.afternoonSunIcon);
  }
  if (lower.contains('evening')) {
    return (icon: Icons.wb_twilight_rounded, color: _MedsColors.eveningIcon);
  }
  if (lower.contains('night')) {
    return (icon: Icons.nightlight_round, color: _MedsColors.nightIcon);
  }
  return (icon: Icons.medication_rounded, color: _MedsColors.morningSunIcon);
}

extension _MedsTabFunctions on _MedsTabScreenState {
  // State-level helpers go here as needed.
}
