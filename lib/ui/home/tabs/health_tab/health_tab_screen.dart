import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:wisecare_frontend/models/vitals/vitals_history_response_model.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/provider/profile_provider.dart';
import 'package:wisecare_frontend/provider/vitals_history_provider.dart';

part 'health_tab_functions.dart';
part 'health_tab_variables.dart';
part 'widgets/health_header.dart';
part 'widgets/health_time_range_filter.dart';
part 'widgets/vital_card.dart';
part 'widgets/heart_rate_trends_chart.dart';
part 'widgets/health_blood_pressure_chart.dart';
part 'widgets/health_risk_distribution.dart';
part 'widgets/health_recent_readings_table.dart';

class HealthTabScreen extends StatefulWidget {
  const HealthTabScreen({super.key});

  @override
  State<HealthTabScreen> createState() => _HealthTabScreenState();
}

class _HealthTabScreenState extends State<HealthTabScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchHistoryIfNeeded());
  }

  void _fetchHistoryIfNeeded() {
    final profile = context.read<ProfileProvider>().profile;
    final userId = profile?.userId;
    if (userId == null || userId.isEmpty) return;
    final historyProvider = context.read<VitalsHistoryProvider>();
    if (!historyProvider.isLoading && historyProvider.history == null) {
      historyProvider.fetchHistory(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _HealthTabColors.background,
      child: Column(
        children: [
          const _HealthHeader(),
          Expanded(
            child: Consumer2<ProfileProvider, VitalsHistoryProvider>(
              builder: (context, profile, historyProvider, _) {
                if (historyProvider.isLoading && historyProvider.history == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                final isRefreshing = historyProvider.isLoading && historyProvider.history != null;
                if (historyProvider.errorMessage != null && historyProvider.history == null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            historyProvider.errorMessage!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              color: _HealthTabColors.trendRed,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => historyProvider.fetchHistory(
                              profile.profile?.userId ?? '',
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isRefreshing) const LinearProgressIndicator(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(
                          _HealthTabDimens.contentPadding,
                          _HealthTabDimens.contentPadding,
                          _HealthTabDimens.contentPadding,
                          _HealthTabDimens.contentBottom,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _HealthTimeRangeFilter(),
                            const SizedBox(height: _HealthTabDimens.sectionGap),
                            _buildStatsGrid(historyProvider),
                            const SizedBox(height: _HealthTabDimens.sectionGap),
                            const _HeartRateTrendsChart(),
                            const SizedBox(height: _HealthTabDimens.sectionGap),
                            const _BloodPressureTrendCard(),
                            const SizedBox(height: _HealthTabDimens.sectionGap),
                            const _RiskDistributionCard(),
                            const SizedBox(height: _HealthTabDimens.sectionGap),
                            const _RecentReadingsTable(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(VitalsHistoryProvider historyProvider) {
    final stats = historyProvider.history?.statistics;
    final heartRateAvg = stats?.heartRate.avg.round();
    final bpSystolic = stats?.bloodPressure.systolic.avg.round();
    final bpDiastolic = stats?.bloodPressure.diastolic.avg.round();
    final dist = stats?.riskDistribution;
    final activeRiskCount = dist != null ? dist.high + dist.critical : 0;

    return Column(
      children: [
        _VitalCard(
          label: 'Avg Heart Rate',
          icon: Icons.favorite_rounded,
          iconColor: _HealthTabColors.iconHeart,
          value: heartRateAvg != null ? '$heartRateAvg' : '—',
          unit: 'BPM',
        ),
        const SizedBox(height: 16),
        _VitalCard(
          label: 'Avg BP',
          icon: Icons.water_drop_outlined,
          iconColor: _HealthTabColors.iconBp,
          value: (bpSystolic != null && bpDiastolic != null) ? '$bpSystolic/$bpDiastolic' : '—',
          unit: 'mmHg',
        ),
        const SizedBox(height: 16),
        _VitalCard(
          label: 'Active Risk Alerts',
          icon: Icons.shield_outlined,
          iconColor: _HealthTabColors.iconShield,
          value: '$activeRiskCount',
          unit: activeRiskCount > 0 ? 'High Priority' : 'Alerts',
          unitColor: activeRiskCount > 0 ? _HealthTabColors.trendRed : null,
          trendText: activeRiskCount > 0 ? 'See resolution steps' : null,
          trendColor: _HealthTabColors.trendMuted,
        ),
      ],
    );
  }
}
