part of 'profile_tab_screen.dart';

/// Shows a dialog to edit date of birth (age). On save calls PUT /users/me.
Future<void> _showEditAgeDialog(
  BuildContext context,
  ProfileProvider provider,
  ProfileModel? profile,
) async {
  DateTime selectedDate = DateTime.now();
  if (profile?.dateOfBirth != null) {
    final parsed = DateTime.tryParse(profile!.dateOfBirth!);
    if (parsed != null) selectedDate = parsed;
  }

  if (!context.mounted) return;
  final picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked == null || !context.mounted) return;

  await provider.updateProfileDetails(
    UpdateProfileRequest(
      dateOfBirth:
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}',
    ),
  );
}

/// Shows a dialog to edit city. On save calls PUT /users/me.
Future<void> _showEditCityDialog(
  BuildContext context,
  ProfileProvider provider,
  ProfileModel? profile,
) async {
  final controller = TextEditingController(text: profile?.city ?? '');
  if (!context.mounted) return;
  final saved = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Edit City'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'City',
          hintText: 'Enter city',
          border: OutlineInputBorder(),
        ),
        autofocus: true,
        textCapitalization: TextCapitalization.words,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Save'),
        ),
      ],
    ),
  );
  if (saved == true && controller.text.trim().isNotEmpty && context.mounted) {
    await provider.updateProfileDetails(
      UpdateProfileRequest(city: controller.text.trim()),
    );
  }
}

/// Shows a dialog to add a new emergency contact. On save appends to list and calls PUT /users/me/emergency-contact.
Future<void> _showAddEmergencyContactDialog(
  BuildContext context,
  ProfileProvider provider,
  List<EmergencyContact> currentContacts,
) async {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final relationshipController = TextEditingController();
  bool isPrimary = currentContacts.isEmpty;

  if (!context.mounted) return;
  final saved = await showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Add Emergency Contact'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Full name',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '+91 9876543210',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: relationshipController,
                  decoration: const InputDecoration(
                    labelText: 'Relationship',
                    hintText: 'e.g. Son, Daughter',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  value: isPrimary,
                  onChanged: (v) => setState(() => isPrimary = v ?? false),
                  title: const Text('Primary contact'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Add'),
            ),
          ],
        );
      },
    ),
  );

  if (saved != true || !context.mounted) return;

  final name = nameController.text.trim();
  final phone = phoneController.text.trim();
  final relationship = relationshipController.text.trim();

  final newList = <EmergencyContact>[];
  if (isPrimary && currentContacts.isNotEmpty) {
    for (final c in currentContacts) {
      newList.add(EmergencyContact(
        name: c.name,
        phoneNumber: c.phoneNumber,
        relationship: c.relationship,
        isPrimary: false,
      ));
    }
  } else {
    newList.addAll(currentContacts);
  }
  newList.add(EmergencyContact(
    name: name.isEmpty ? '—' : name,
    phoneNumber: phone.isEmpty ? '—' : phone,
    relationship: relationship.isEmpty ? '—' : relationship,
    isPrimary: isPrimary,
  ));

  await provider.updateEmergencyContacts(newList);
}
