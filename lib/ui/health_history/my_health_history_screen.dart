import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/models/health_history/health_pattern_model.dart';
import 'package:wisecare_frontend/models/health_history/health_recommendation_model.dart';
import 'package:wisecare_frontend/models/health_history/health_timeline_item_model.dart';
import 'package:wisecare_frontend/provider/health_history_provider.dart';
import 'package:wisecare_frontend/provider/profile_provider.dart';
import 'package:wisecare_frontend/utils/theme/colors/app_color.dart';
import 'package:wisecare_frontend/utils/theme/theme_manager.dart';

part 'my_health_history_functions.dart';
part 'my_health_history_variables.dart';
part 'widgets/my_health_history_header.dart';
part 'widgets/my_health_history_summary_strip.dart';
part 'widgets/my_health_history_recommended_actions.dart';
part 'widgets/my_health_history_detected_patterns.dart';
part 'widgets/my_health_history_activity_timeline.dart';

class MyHealthHistoryScreen extends StatefulWidget {
  const MyHealthHistoryScreen({super.key});

  @override
  State<MyHealthHistoryScreen> createState() => _MyHealthHistoryScreenState();
}

class _MyHealthHistoryScreenState extends State<MyHealthHistoryScreen> {
  bool _loaded = false;
  int _selectedDays = 30;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    _loaded = true;
    final profile = context.read<ProfileProvider>().profile;
    final userId = profile?.userId ?? '';
    if (userId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<HealthHistoryProvider>().loadHealthTimeline(
                userId: userId,
                days: _selectedDays,
              );
        }
      });
    }
  }

  void _onDaysChanged(int days) {
    if (days == _selectedDays) return;
    setState(() => _selectedDays = days);
    final userId = context.read<ProfileProvider>().profile?.userId ?? '';
    if (userId.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<HealthHistoryProvider>().loadHealthTimeline(
            userId: userId,
            days: days,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Skin.color(Co.contentBackground),
      body: SafeArea(
        top: false,
        child: Consumer<HealthHistoryProvider>(
          builder: (context, healthProvider, _) {
            final profile = context.read<ProfileProvider>().profile;
            final userId = profile?.userId ?? '';
            if (userId.isEmpty && !healthProvider.isLoading) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Profile not loaded. Please try again.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      color: Skin.color(Co.onBackground),
                    ),
                  ),
                ),
              );
            }
            if (healthProvider.isLoading && healthProvider.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final isRefetching =
                healthProvider.isLoading && healthProvider.data != null;
            if (healthProvider.errorMessage != null && healthProvider.data == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    healthProvider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      color: Skin.color(Co.onBackground),
                    ),
                  ),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MyHealthHistoryHeader(
                  dateRangeLabel: 'Last $_selectedDays Days',
                  selectedDays: _selectedDays,
                  onDaysChanged: _onDaysChanged,
                ),
                if (isRefetching)
                  LinearProgressIndicator(
                    backgroundColor: Skin.color(Co.borderSubtle),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Skin.color(Co.primary),
                    ),
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 111),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MyHealthHistorySummaryStrip(
                          totalEvents: healthProvider.totalHealthEvents,
                          patternsCount: healthProvider.patternsDetected,
                        ),
                        const SizedBox(height: 8),
                        _MyHealthHistoryRecommendedActions(
                          recommendations: healthProvider.recommendations,
                        ),
                        const SizedBox(height: _MyHealthHistoryDimens.sectionGap),
                        _MyHealthHistoryDetectedPatterns(
                          patterns: healthProvider.patterns,
                        ),
                        const SizedBox(height: _MyHealthHistoryDimens.sectionGap),
                        _MyHealthHistoryActivityTimeline(
                          timeline: healthProvider.timeline,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
