import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wisecare_frontend/utils/theme/colors/app_color.dart';
import 'package:wisecare_frontend/utils/theme/theme_manager.dart';

/// Full-screen health timeline view (date range / filters and timeline).
class HealthTimelineScreen extends StatelessWidget {
  const HealthTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Skin.color(Co.contentBackground),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const _HealthTimelineHeader(),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Health Timeline',
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Skin.color(Co.onBackground),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HealthTimelineHeader extends StatelessWidget {
  const _HealthTimelineHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: Skin.color(Co.gradientTop),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (context.mounted) context.pop();
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Skin.color(Co.headerButtonOverlay),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Skin.color(Co.onPrimary),
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Health Timeline',
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Skin.color(Co.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
