import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wisecare_frontend/ui/onboarding/onboarding_shared.dart';

part 'basic_info_slide_functions.dart';
part 'basic_info_slide_variables.dart';
part 'widgets/basic_info_slide_widgets.dart';

/// First onboarding slide: Basic Info. Parent uses [BasicInfoSlideScreenState.getBasicInfoForSubmit].
class BasicInfoSlideScreen extends StatefulWidget {
  const BasicInfoSlideScreen({super.key});

  @override
  State<BasicInfoSlideScreen> createState() => BasicInfoSlideScreenState();
}

class BasicInfoSlideScreenState extends State<BasicInfoSlideScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emergencyNameController = TextEditingController();
  final TextEditingController _emergencyNumberController = TextEditingController();

  DateTime? _dob;
  int _selectedGender = 0; // 0 Male, 1 Female
  String? _bloodGroup;
  String? _emergencyRelationship;
  final Set<String> _medicalConditions = <String>{};

  (Map<String, dynamic>?, String?) getBasicInfoForSubmit() {
    final dobStr = _dob != null ? formatDobForApi(_dob!) : null;
    return buildBasicInfoPayload(
      dob: dobStr,
      address: _addressController.text,
      emergencyName: _emergencyNameController.text,
      emergencyRelationship: _emergencyRelationship ?? '',
      emergencyNumber: _emergencyNumberController.text,
      selectedGender: _selectedGender,
      bloodGroup: _bloodGroup,
      medicalConditions: _medicalConditions,
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    _emergencyNameController.dispose();
    _emergencyNumberController.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _pickDob() async {
    final initial = _dob ?? DateTime(1990, 1, 15);
    final first = DateTime(1900);
    final last = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
    );
    if (picked != null && mounted) {
      setState(() => _dob = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: OnboardingDimens.greetingPaddingTop,
        left: OnboardingDimens.greetingPaddingH,
        right: OnboardingDimens.greetingPaddingH,
        bottom: OnboardingDimens.formPaddingBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Basic Info',
            style: GoogleFonts.lexend(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 38 / 30,
              letterSpacing: -0.75,
              color: OnboardingColors.textPrimary,
            ),
          ),
          const SizedBox(height: OnboardingDimens.greetingGap),
          Text(
            "Let's start by getting to know you better for your WiseCare profile.",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 26 / 16,
              color: OnboardingColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          const _BasicInfoLabel('Date of Birth'),
          const SizedBox(height: OnboardingDimens.labelInputGap),
          _BasicInfoDatePickerField(
            value: _dob,
            hint: 'Select date (YYYY-MM-DD)',
            onTap: _pickDob,
          ),
          const SizedBox(height: OnboardingDimens.formFieldGap),
          const _BasicInfoLabel('Gender'),
          const SizedBox(height: OnboardingDimens.labelInputGap),
          Row(
            children: [
              Expanded(
                child: BasicInfoGenderChip(
                  label: 'Male',
                  selected: _selectedGender == 0,
                  onTap: () {
                    _selectedGender = 0;
                    _refresh();
                  },
                ),
              ),
              const SizedBox(width: OnboardingDimens.toggleGap),
              Expanded(
                child: BasicInfoGenderChip(
                  label: 'Female',
                  selected: _selectedGender == 1,
                  onTap: () {
                    _selectedGender = 1;
                    _refresh();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: OnboardingDimens.formFieldGap),
          const _BasicInfoLabel('Address'),
          const SizedBox(height: OnboardingDimens.labelInputGap),
          _BasicInfoTextArea(
            controller: _addressController,
            hint: 'e.g. 123 Main Street, Apartment 4B',
          ),
          const SizedBox(height: OnboardingDimens.formFieldGap),
          const _BasicInfoLabel('Emergency Contact'),
          const SizedBox(height: OnboardingDimens.labelInputGap),
          _BasicInfoInput(
            controller: _emergencyNameController,
            hint: 'Name (e.g. John Doe)',
          ),
          const SizedBox(height: OnboardingDimens.labelInputGap),
          _BasicInfoDropdown(
            value: _emergencyRelationship,
            hint: 'Relationship',
            options: _emergencyRelationshipOptions,
            onChanged: (v) {
              _emergencyRelationship = v;
              _refresh();
            },
          ),
          const SizedBox(height: OnboardingDimens.labelInputGap),
          _BasicInfoInputWithPrefix(
            controller: _emergencyNumberController,
            prefix: '+91',
            hint: 'Mobile number',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: OnboardingDimens.formFieldGap),
          const _BasicInfoLabel('Blood Group'),
          const SizedBox(height: OnboardingDimens.labelInputGap),
          _BasicInfoDropdown(
            value: _bloodGroup,
            hint: 'Select blood group',
            options: _bloodGroups,
            onChanged: (v) {
              _bloodGroup = v;
              _refresh();
            },
          ),
          const SizedBox(height: OnboardingDimens.formFieldGap),
          const _BasicInfoLabel('Medical Conditions'),
          const SizedBox(height: OnboardingDimens.labelInputGap),
          Text(
            'Select all that apply',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
              color: OnboardingColors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ..._conditionOptions.map((c) => BasicInfoConditionChip(
                    label: c,
                    selected: _medicalConditions.contains(c),
                    onTap: () {
                      if (_medicalConditions.contains(c)) {
                        _medicalConditions.remove(c);
                      } else {
                        _medicalConditions.add(c);
                      }
                      _refresh();
                    },
                  )),
              BasicInfoConditionChip(
                label: '+ Add Other',
                selected: false,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
