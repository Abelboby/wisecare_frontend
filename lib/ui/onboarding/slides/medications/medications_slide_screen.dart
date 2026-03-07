import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wisecare_frontend/ui/onboarding/onboarding_shared.dart';

part 'medications_slide_functions.dart';
part 'medications_slide_variables.dart';
part 'widgets/medications_slide_widgets.dart';

/// Second onboarding slide: Medications. Parent uses [MedicationsSlideScreenState.getMedicationsForSubmit].
class MedicationsSlideScreen extends StatefulWidget {
  const MedicationsSlideScreen({super.key});

  @override
  State<MedicationsSlideScreen> createState() => MedicationsSlideScreenState();
}

class MedicationsSlideScreenState extends State<MedicationsSlideScreen> {
  final List<MedicationEntry> _medications = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  String _frequency = 'Twice daily';
  TimeOfDay _preferredTime = const TimeOfDay(hour: 8, minute: 0);

  (List<Map<String, String>>?, String?) getMedicationsForSubmit() {
    return buildMedicationsPayload(_medications);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  void _addMedication() {
    final name = _nameController.text.trim();
    final dosage = _dosageController.text.trim();
    if (name.isEmpty && dosage.isEmpty) return;
    setState(() {
      _medications.add(MedicationEntry(
        name: name.isEmpty ? 'Medication' : name,
        dosage: dosage.isEmpty ? '—' : dosage,
        frequency: _frequency,
        times: timesForFrequency(_frequency, _preferredTime.hour, _preferredTime.minute),
      ));
      _nameController.clear();
      _dosageController.clear();
      _frequency = 'Twice daily';
      _preferredTime = const TimeOfDay(hour: 8, minute: 0);
    });
  }

  void _removeMedication(int index) {
    setState(() => _medications.removeAt(index));
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _preferredTime,
    );
    if (picked != null && mounted) setState(() => _preferredTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OnboardingColors.medicationsBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: MedicationsDimens.mainPaddingH,
          vertical: MedicationsDimens.mainPaddingV,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MedicationsSectionHeader(onAddNew: _addMedication),
            ..._medications.asMap().entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8,top: 16),
                  child: _MedicationCard(
                    entry: e.value,
                    onDelete: () => _removeMedication(e.key),
                  ),
                )),
            const SizedBox(height: 16),
            _AddMedicationForm(
              nameController: _nameController,
              dosageController: _dosageController,
              frequency: _frequency,
              onFrequencyChanged: (v) {
                if (mounted) setState(() => _frequency = v ?? _frequency);
              },
              preferredTime: _preferredTime,
              onTimeTap: _pickTime,
              onAddAnother: _addMedication,
            ),
            const SizedBox(height: MedicationsDimens.footerSpacerHeight),
          ],
        ),
      ),
    );
  }
}
