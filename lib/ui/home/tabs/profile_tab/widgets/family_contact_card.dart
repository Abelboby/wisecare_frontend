part of '../profile_tab_screen.dart';

class _FamilyContactSectionTitle extends StatelessWidget {
  const _FamilyContactSectionTitle({
    required this.title,
    this.onAddTap,
  });

  final String title;
  final VoidCallback? onAddTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _ProfileTabDimens.sectionTitleLeftPadding,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.lexend(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 28 / 20,
              color: Skin.color(Co.onBackground),
            ),
          ),
          if (onAddTap != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onAddTap,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Skin.color(Co.primary).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add_rounded,
                  size: 22,
                  color: Skin.color(Co.primary),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FamilyContactCard extends StatelessWidget {
  const _FamilyContactCard({
    required this.contacts,
    required this.onAddContact,
  });

  final List<EmergencyContact> contacts;
  final VoidCallback onAddContact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FamilyContactSectionTitle(
          title: 'Family Contact',
          onAddTap: onAddContact,
        ),
        const SizedBox(height: _ProfileTabDimens.sectionGap),
        Container(
          decoration: BoxDecoration(
            color: Skin.color(Co.cardSurface),
            border: Border.all(color: Skin.color(Co.outline)),
            borderRadius: BorderRadius.circular(_ProfileTabDimens.cardRadius),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: contacts.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(_ProfileTabDimens.cardPadding),
                  child: _FamilyContactEmptyState(),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: contacts.length,
                  separatorBuilder: (_, __) => const Divider(
                    color: Color(0xFFF8FAFC),
                    thickness: 1,
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  itemBuilder: (context, index) {
                    const pad = _ProfileTabDimens.cardPadding;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: pad,
                        right: pad,
                        top: pad,
                        bottom: pad,
                      ),
                      child: _FamilyContactRow(contact: contacts[index]),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _FamilyContactRow extends StatelessWidget {
  const _FamilyContactRow({required this.contact});

  final EmergencyContact contact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _FamilyContactInitialsAvatar(initials: contact.initials),
            const SizedBox(width: _ProfileTabDimens.detailIconGap),
            _FamilyContactInfo(contact: contact),
          ],
        ),
        const _FamilyContactCallButton(),
      ],
    );
  }
}

class _FamilyContactEmptyState extends StatelessWidget {
  const _FamilyContactEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No emergency contact set. Tap + to add.',
        style: GoogleFonts.lexend(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 24 / 16,
          color: Skin.color(Co.textMuted),
        ),
      ),
    );
  }
}

class _FamilyContactInitialsAvatar extends StatelessWidget {
  const _FamilyContactInitialsAvatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _ProfileTabDimens.contactAvatarSize,
      height: _ProfileTabDimens.contactAvatarSize,
      decoration: BoxDecoration(
        color: Skin.color(Co.primary).withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: GoogleFonts.lexend(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 28 / 20,
          color: Skin.color(Co.primary),
        ),
      ),
    );
  }
}

class _FamilyContactInfo extends StatelessWidget {
  const _FamilyContactInfo({required this.contact});

  final EmergencyContact contact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contact.name.isEmpty ? '—' : contact.name,
          style: GoogleFonts.lexend(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 28 / 20,
            color: Skin.color(Co.onBackground),
          ),
        ),
        Text(
          contact.phoneNumber,
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 24 / 16,
            color: Skin.color(Co.textMuted),
          ),
        ),
        Text(
          contact.relationshipLabel,
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 24 / 16,
            color: Skin.color(Co.textMuted),
          ),
        ),
      ],
    );
  }
}

class _FamilyContactCallButton extends StatelessWidget {
  const _FamilyContactCallButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Skin.color(Co.primary),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.phone_rounded,
        color: Skin.color(Co.onPrimary),
        size: 22.5,
      ),
    );
  }
}
