part of 'medications_slide_screen.dart';

/// Builds medications payload for API. Returns (payload, null) when valid; (null, errorMessage) when validation fails.
(List<Map<String, String>>?, String?) buildMedicationsPayload(List<MedicationEntry> medications) {
  if (medications.isEmpty) {
    return (null, 'Add at least one medication.');
  }
  final list = <Map<String, String>>[];
  for (final m in medications) {
    final time = m.times.isNotEmpty ? m.times.first : '08:00';
    list.add(<String, String>{
      'name': m.name,
      'dosage': m.dosage,
      'frequency': m.frequency,
      'time': time,
    });
  }
  return (list, null);
}

List<String> timesForFrequency(String freq, int hour24, int minute) {
  String chip(int h) => '${h.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  if (freq == 'Once daily') return [chip(hour24)];
  if (freq == 'Twice daily') return [chip(hour24), chip((hour24 + 12) % 24)];
  if (freq == 'Three times daily') {
    return [chip(hour24), chip((hour24 + 8) % 24), chip((hour24 + 16) % 24)];
  }
  return [chip(hour24)];
}
