import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wisecare_frontend/enums/app_enums.dart';
import 'package:wisecare_frontend/provider/profile_provider.dart';
import 'package:wisecare_frontend/utils/theme/colors/app_color.dart';
import 'package:wisecare_frontend/utils/theme/theme_manager.dart';

part 'profile_tab_functions.dart';
part 'profile_tab_variables.dart';
part 'widgets/sign_out_button.dart';

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _ProfileTabColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(_ProfileTabDimens.contentPadding),
          child: Consumer<ProfileProvider>(
            builder: (context, provider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Profile',
                    style: GoogleFonts.lexend(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 32 / 24,
                      color: _ProfileTabColors.titleText,
                    ),
                  ),
                  const SizedBox(height: _ProfileTabDimens.contentGap),
                  if (provider.errorMessage != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        provider.errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  _SignOutButton(
                    isLoading: provider.isLoading,
                    onTap: () => provider.signOut(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
