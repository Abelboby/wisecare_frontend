part of 'basic_info_slide_screen.dart';

/// Format [date] as YYYY-MM-DD for API.
String formatDobForApi(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

/// Builds basic info payload for API. Returns (payload, null) when valid; (null, errorMessage) when validation fails.
/// [dob] in format YYYY-MM-DD. [emergencyContact] has name, relationship, number.
(Map<String, dynamic>?, String?) buildBasicInfoPayload({
  required String? dob,
  required String address,
  required String emergencyName,
  required String emergencyRelationship,
  required String emergencyNumber,
  required int selectedGender,
  String? bloodGroup,
  required Set<String> medicalConditions,
}) {
  final dobTrim = dob?.trim();
  if (dobTrim == null || dobTrim.isEmpty) {
    return (null, 'Please select your date of birth.');
  }
  final dobMatch = RegExp(r'^\d{4}-\d{2}-\d{2}$').firstMatch(dobTrim);
  if (dobMatch == null) {
    return (null, 'Date of birth must be in YYYY-MM-DD format.');
  }
  final addressTrim = address.trim();
  if (addressTrim.isEmpty) return (null, 'Please enter your full address.');
  final nameTrim = emergencyName.trim();
  if (nameTrim.isEmpty) return (null, 'Please enter emergency contact name.');
  final relationshipTrim = emergencyRelationship.trim();
  if (relationshipTrim.isEmpty) return (null, 'Please select emergency contact relationship.');
  final numberTrim = emergencyNumber.trim();
  if (numberTrim.isEmpty) return (null, 'Please enter emergency contact number.');
  final number = numberTrim.startsWith('+') ? numberTrim : '+91$numberTrim';
  final gender = selectedGender == 0 ? 'Male' : 'Female';
  final payload = <String, dynamic>{
    'dob': dobTrim,
    'gender': gender,
    'address': addressTrim,
    'emergencyContact': <String, dynamic>{
      'name': nameTrim,
      'relationship': relationshipTrim,
      'number': number,
    },
  };
  if (bloodGroup != null && bloodGroup.isNotEmpty) payload['bloodGroup'] = bloodGroup;
  if (medicalConditions.isNotEmpty) {
    payload['preExistingConditions'] = medicalConditions.toList();
  }
  return (payload, null);
}
