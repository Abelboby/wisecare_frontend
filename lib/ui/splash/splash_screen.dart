import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/widgets/common/svg_image.dart';
import 'package:wisecare_frontend/enums/app_enums.dart';
import 'package:wisecare_frontend/gen/assets.gen.dart';
import 'package:wisecare_frontend/navigation/app_navigator.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/provider/splash_provider.dart';
import 'package:wisecare_frontend/utils/theme/colors/app_color.dart';
import 'package:wisecare_frontend/utils/theme/theme_manager.dart';

part 'splash_functions.dart';

/// Splash screen. All colors use [Skin.color](Co.xxx) so they follow the
/// current theme (light / grayscale / dark).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Skin.color(Co.background),
      body: ValueListenableBuilder<AppThemeMode>(
        valueListenable: Skin.themeMode,
        builder: (_, __, ___) {
          return Consumer<SplashProvider>(
            builder: (context, provider, _) {
              if (provider.error != null) {
                return _SplashErrorBody(message: provider.error!);
              }
              return const _SplashBodyContent();
            },
          );
        },
      ),
    );
  }
}

class _SplashErrorBody extends StatelessWidget {
  const _SplashErrorBody({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Skin.color(Co.gradientTop),
            Skin.color(Co.gradientBottom),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Skin.color(Co.onPrimary)),
          ),
        ),
      ),
    );
  }
}

class _SplashBodyContent extends StatelessWidget {
  const _SplashBodyContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Skin.color(Co.gradientTop),
            Skin.color(Co.gradientBottom),
          ],
        ),
      ),
      child: Stack(
        children: [
          _SplashBlurDecorations(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: _SplashCenterContent(),
                ),
                const _SplashBottomProgress(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashBlurDecorations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Skin.color(Co.primary).withValues(alpha: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: Skin.color(Co.primary).withValues(alpha: 0.2),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5 - 72,
            left: -20,
            child: Container(
              width: 288,
              height: 288,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Skin.color(Co.accentBlur).withValues(alpha: 0.25),
                boxShadow: [
                  BoxShadow(
                    color: Skin.color(Co.accentBlur).withValues(alpha: 0.15),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashCenterContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _SplashLogoSection(),
            const SizedBox(height: 48),
            const _SplashTitleSection(),
            const SizedBox(height: 16),
            const _SplashSubtitleSection(),
          ],
        ),
      ),
    );
  }
}

class _SplashLogoSection extends StatelessWidget {
  const _SplashLogoSection();

  static const double _iconSize = 120;

  @override
  Widget build(BuildContext context) {
    return SvgImage(
      Assets.icons.appIconSvg.path,
      width: _iconSize,
      height: _iconSize * (256 / 278),
      fit: BoxFit.contain,
    );
  }
}

class _SplashTitleSection extends StatelessWidget {
  const _SplashTitleSection();

  @override
  Widget build(BuildContext context) {
    return Text(
      'WiseCare',
      style: TextStyle(
        color: Skin.color(Co.onPrimary),
        fontSize: 48,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.2,
        shadows: [
          Shadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _SplashSubtitleSection extends StatelessWidget {
  const _SplashSubtitleSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Text(
        'Your companion for a healthier life',
        style: TextStyle(
          color: Skin.color(Co.onPrimary).withValues(alpha: 0.8),
          fontSize: 20,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _SplashBottomProgress extends StatelessWidget {
  const _SplashBottomProgress();

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(
      builder: (context, provider, _) {
        final progress = provider.progress;
        return Padding(
          padding: const EdgeInsets.fromLTRB(48, 0, 48, 64),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor:
                      Skin.color(Co.onPrimary).withValues(alpha: 0.15),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Skin.color(Co.primary)),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Establishing Secure Connection...',
                style: TextStyle(
                  color: Skin.color(Co.onPrimary).withValues(alpha: 0.5),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
