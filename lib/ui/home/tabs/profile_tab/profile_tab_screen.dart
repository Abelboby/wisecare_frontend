import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wisecare_frontend/models/profile/profile_model.dart';
import 'package:wisecare_frontend/provider/profile_provider.dart';
import 'package:wisecare_frontend/utils/theme/colors/app_color.dart';
import 'package:wisecare_frontend/utils/theme/theme_manager.dart';

part 'profile_tab_functions.dart';
part 'profile_tab_variables.dart';
part 'widgets/sign_out_button.dart';
part 'widgets/profile_header.dart';
part 'widgets/my_details_card.dart';
part 'widgets/family_contact_card.dart';
part 'widgets/app_settings_card.dart';

class ProfileTabScreen extends StatefulWidget {
  const ProfileTabScreen({super.key});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  bool _profileRequested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_profileRequested) {
      _profileRequested = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.read<ProfileProvider>().loadProfile();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Skin.color(Co.warmBackground),
      child: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          if (provider.isProfileLoading && provider.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = provider.profile;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _ProfileHeader(
                  name: profile?.name ?? '—',
                  memberSince:
                      profile != null && profile.memberSince.isNotEmpty ? 'Member since ${profile.memberSince}' : '',
                  role: profile?.role,
                  imageUrl: profile?.profilePhotoUrl,
                  onEditPhotoTap: provider.uploadProfilePhoto,
                  isUploadingPhoto: provider.isUploadingPhoto,
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
                            style: TextStyle(
                              color: Skin.color(Co.error),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      _MyDetailsCard(
                        age: profile?.ageLabel,
                        city: profile?.city,
                        cityImageUrl: profile?.cityImageUrl,
                        onEditAge: () => _showEditAgeDialog(context, provider, profile),
                        onEditCity: () => _showEditCityDialog(context, provider, profile),
                      ),
                      const SizedBox(height: _ProfileTabDimens.contentGap),
                      _FamilyContactCard(
                        contacts: profile?.emergencyContacts ?? const [],
                        onAddContact: () => _showAddEmergencyContactDialog(
                          context,
                          provider,
                          profile?.emergencyContacts ?? const [],
                        ),
                      ),
                      const SizedBox(height: _ProfileTabDimens.contentGap),
                      _AppSettingsCard(
                        settings: profile?.settings,
                        onSettingsChanged: provider.updateSettings,
                      ),
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
