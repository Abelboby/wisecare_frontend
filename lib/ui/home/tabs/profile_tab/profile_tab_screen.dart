import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wisecare_frontend/provider/profile_provider.dart';

part 'profile_tab_functions.dart';
part 'profile_tab_variables.dart';
part 'widgets/sign_out_button.dart';
part 'widgets/profile_header.dart';
part 'widgets/my_details_card.dart';
part 'widgets/family_contact_card.dart';
part 'widgets/app_settings_card.dart';

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _ProfileTabColors.background,
      child: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _ProfileHeader(
                  name: 'Raghav Kumar',
                  memberSince: 'Member since 2022',
                  imageUrl: null,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: _ProfileTabDimens.contentTopPadding,
                    left: _ProfileTabDimens.contentHorizontalPadding,
                    right: _ProfileTabDimens.contentHorizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (provider.errorMessage != null)
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
                      const _MyDetailsCard(
                        age: '68 Years',
                        city: 'Chennai, TN',
                      ),
                      const SizedBox(height: _ProfileTabDimens.contentGap),
                      const _FamilyContactCard(
                        name: 'Arjun Kumar',
                        initials: 'AK',
                        relationship: 'Son • Emergency Contact',
                      ),
                      const SizedBox(height: _ProfileTabDimens.contentGap),
                      const _AppSettingsCard(),
                      const SizedBox(height: _ProfileTabDimens.contentGap),
                      _SignOutButton(
                        isLoading: provider.isLoading,
                        onTap: provider.signOut,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
