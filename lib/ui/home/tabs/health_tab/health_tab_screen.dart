import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wisecare_frontend/enums/app_enums.dart';
import 'package:wisecare_frontend/provider/home_provider.dart';

part 'health_tab_functions.dart';
part 'health_tab_variables.dart';
part 'widgets/health_header.dart';
part 'widgets/low_risk_banner.dart';
part 'widgets/vital_card.dart';
part 'widgets/heart_rate_trends_chart.dart';
part 'widgets/reading_item.dart';

class HealthTabScreen extends StatelessWidget {
  const HealthTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _HealthTabColors.background,
      child: Column(
        children: [
          const _HealthHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                _HealthTabDimens.contentPaddingHorizontal,
                _HealthTabDimens.contentPaddingTop,
                _HealthTabDimens.contentPaddingHorizontal,
                _HealthTabDimens.contentPaddingBottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _LowRiskBanner(userName: 'Raghav'),
                  const SizedBox(height: _HealthTabDimens.sectionGap),
                  _buildCurrentReadingsSection(),
                  const SizedBox(height: _HealthTabDimens.sectionGap),
                  const _HeartRateTrendsChart(),
                  const SizedBox(height: _HealthTabDimens.sectionGap),
                  _buildLatestReadingsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentReadingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Current Readings',
            style: GoogleFonts.lexend(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 28 / 20,
              color: _HealthTabColors.sectionTitle,
            ),
          ),
        ),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: _VitalCard(
                  icon: Icons.favorite_rounded,
                  label: 'Heart Rate',
                  value: '72',
                  valueUnit: 'BPM',
                ),
              ),
              const SizedBox(width: _HealthTabDimens.cardGap),
              Expanded(
                child: _VitalCard(
                  icon: Icons.water_drop_outlined,
                  label: 'Blood Pressure',
                  value: '120/80',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLatestReadingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            'Latest Readings',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 28 / 18,
              color: _HealthTabColors.sectionTitle,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const _ReadingItem(
          iconData: Icons.water_drop_outlined,
          iconColor: _HealthTabColors.oxygenIcon,
          iconBgColor: _HealthTabColors.oxygenIconBg,
          title: 'Oxygen Level',
          subtitle: 'Today, 9:00 AM',
          value: '98%',
          statusLabel: 'Good',
        ),
        const SizedBox(height: _HealthTabDimens.readingItemGap),
        const _ReadingItem(
          iconData: Icons.thermostat_outlined,
          iconColor: _HealthTabColors.tempIcon,
          iconBgColor: _HealthTabColors.tempIconBg,
          title: 'Temperature',
          subtitle: 'Yesterday, 8:00 PM',
          value: '98.4°F',
          statusLabel: 'Good',
        ),
        const SizedBox(height: _HealthTabDimens.readingItemGap),
        const _ReadingItem(
          iconData: Icons.monitor_weight_outlined,
          iconColor: _HealthTabColors.weightIcon,
          iconBgColor: _HealthTabColors.weightIconBg,
          title: 'Weight',
          subtitle: 'Yesterday, 8:00 AM',
          value: '74 kg',
          statusLabel: 'Stable',
        ),
      ],
    );
  }
}
