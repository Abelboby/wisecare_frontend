part of 'medications_slide_screen.dart';

/// Single medication entry for the medications slide.
class MedicationEntry {
  MedicationEntry({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.times,
  });

  final String name;
  final String dosage;
  final String frequency;
  final List<String> times;
}

const List<String> _frequencyOptions = [
  'Once daily',
  'Twice daily',
  'Three times daily',
  'As needed',
];
