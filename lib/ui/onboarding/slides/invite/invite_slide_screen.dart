import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import 'package:wisecare_frontend/ui/onboarding/onboarding_shared.dart';

part 'invite_slide_functions.dart';
part 'invite_slide_variables.dart';
part 'widgets/invite_slide_widgets.dart';

/// Third onboarding slide: Connect Family / invite code. Parent calls POST /onboarding/elderly/generate-invite on Complete.
class InviteSlideScreen extends StatelessWidget {
  const InviteSlideScreen({super.key, this.inviteCode, this.expiresAt});

  final String? inviteCode;

  /// ISO datetime when the code expires (from generate-invite response).
  final String? expiresAt;

  @override
  Widget build(BuildContext context) {
    final code = inviteCode != null && inviteCode!.isNotEmpty ? inviteCode! : _InviteSlidePlaceholder.code;
    return Container(
      color: OnboardingColors.medicationsBackground,
      padding: const EdgeInsets.symmetric(horizontal: InviteSlideDimens.mainPaddingH),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: InviteSlideDimens.mainPaddingV),
          const _InviteHeader(),
          SizedBox(height: 16),
          const _InviteIllustration(),
          SizedBox(height: 24),
          _InviteCodeCard(
            code: code,
            expiresAt: expiresAt,
            onCopy: () => copyInviteCode(context, code),
            onShare: () => shareInviteCode(code),
          ),
          SizedBox(height: 16),
          const _InviteTrustIndicator(),
        ],
      ),
    );
  }
}
