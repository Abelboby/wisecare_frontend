import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wisecare_frontend/models/meds/medication_model.dart';
import 'package:wisecare_frontend/models/meds/refill_suggestion_model.dart';
import 'package:wisecare_frontend/provider/meds_provider.dart';

part 'meds_tab_functions.dart';
part 'meds_tab_variables.dart';
part 'widgets/meds_header.dart';
part 'widgets/meds_greeting.dart';
part 'widgets/meds_dose_section_header.dart';
part 'widgets/featured_medication_card.dart';
part 'widgets/compact_medication_card.dart';
part 'widgets/refill_prescription_card.dart';

class MedsTabScreen extends StatefulWidget {
  const MedsTabScreen({super.key});

  @override
  State<MedsTabScreen> createState() => _MedsTabScreenState();
}

class _MedsTabScreenState extends State<MedsTabScreen> {
  bool _scheduleLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_scheduleLoaded) {
      _scheduleLoaded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.read<MedsProvider>().loadSchedule();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _MedsColors.background,
      child: Column(
        children: [
          const _MedsHeader(),
          Expanded(
            child: Consumer<MedsProvider>(
              builder: (context, medsProvider, _) {
                if (medsProvider.isLoading && medsProvider.schedule == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (medsProvider.errorMessage != null && medsProvider.schedule == null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(_MedsDimens.errorStatePadding),
                      child: Text(
                        medsProvider.errorMessage!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexend(
                          fontSize: _MedsTextSizes.errorMessage,
                          color: _MedsColors.greetingText,
                        ),
                      ),
                    ),
                  );
                }
                final schedule = medsProvider.schedule;
                if (schedule == null) return const SizedBox.shrink();
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      _MedsDimens.contentPaddingH,
                      _MedsDimens.contentPaddingTop,
                      _MedsDimens.contentPaddingH,
                      _MedsDimens.contentPaddingBottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MedsGreeting(userName: schedule.userName),
                        const SizedBox(height: _MedsDimens.sectionGap),
                        ...schedule.doseSections.map((section) {
                          final phase = _computePhase(section.label);
                          final featuredIdx = _featuredMedIndex(phase, section.medications);
                          final iconStyle = _sectionIconStyle(section.label);

                          // Past sections: full opacity, all compact (taken or missed)s.
                          // Current section: full opacity, first untaken is featured.
                          // Upcoming sections: dimmed, all compact.
                          final opacity = phase == _SectionPhase.upcoming ? 0.7 : 1.0;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: _MedsDimens.sectionGap),
                            child: Opacity(
                              opacity: opacity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _MedsDoseSectionHeader(
                                    label: section.label,
                                    time: section.time,
                                    icon: iconStyle.icon,
                                    iconColor: iconStyle.color,
                                  ),
                                  const SizedBox(height: _MedsDimens.cardGap),
                                  ...section.medications.asMap().entries.map((e) {
                                    final medIdx = e.key;
                                    final med = e.value;
                                    // Only the first untaken med in the current
                                    // section gets the large featured card.
                                    if (medIdx == featuredIdx) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: _MedsDimens.cardGap),
                                        child: _FeaturedMedicationCard(
                                          medication: med,
                                          isMarkingTaken: medsProvider.isMarkingTaken(med.id),
                                          onMarkAsTaken: () => medsProvider.markAsTaken(med.id),
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: _MedsDimens.cardGap),
                                      child: _CompactMedicationCard(medication: med),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        }),
                        ...schedule.refillSuggestions.map((suggestion) {
                          return Padding(
                            padding: const EdgeInsets.only(top: _MedsDimens.refillSectionTopPadding),
                            child: _RefillPrescriptionCard(
                              suggestion: suggestion,
                              onTap: () => medsProvider.requestRefill(suggestion.medicationId),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
