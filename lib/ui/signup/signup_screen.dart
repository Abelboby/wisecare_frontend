import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/enums/app_enums.dart';
import 'package:wisecare_frontend/gen/assets.gen.dart';
import 'package:wisecare_frontend/navigation/app_navigator.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/provider/signup_provider.dart';
import 'package:wisecare_frontend/utils/theme/colors/app_color.dart';
import 'package:wisecare_frontend/utils/theme/theme_manager.dart';
import 'package:wisecare_frontend/widgets/common/svg_image.dart';

part 'signup_functions.dart';
part 'signup_variables.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    _cityController.dispose();
    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _mobileFocusNode.dispose();
    _cityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Skin.color(Co.warmBackground),
      body: Padding(
        padding: EdgeInsets.only(
          left: padding.left,
          right: padding.right,
        ),
        child: ValueListenableBuilder<AppThemeMode>(
          valueListenable: Skin.themeMode,
          builder: (_, __, ___) => Consumer<SignupProvider>(
            builder: (context, provider, _) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                behavior: HitTestBehavior.opaque,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _SignupHeader(),
                      _SignupCard(
                        fullNameController: _fullNameController,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        mobileController: _mobileController,
                        cityController: _cityController,
                        fullNameFocusNode: _fullNameFocusNode,
                        emailFocusNode: _emailFocusNode,
                        passwordFocusNode: _passwordFocusNode,
                        mobileFocusNode: _mobileFocusNode,
                        cityFocusNode: _cityFocusNode,
                        onCreateAccount: () => _handleCreateAccount(context),
                      ),
                      const _SignupFooter(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _SignupHeader extends StatelessWidget {
  const _SignupHeader();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topInset + 16,
        left: 24,
        right: 24,
        bottom: 56,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_SignupDimens.headerBottomRadius),
          bottomRight: Radius.circular(_SignupDimens.headerBottomRadius),
        ),
        boxShadow: [
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _SignupNavBar(),
          SizedBox(height: 24),
          _SignupLogoSection(),
        ],
      ),
    );
  }
}

class _SignupNavBar extends StatelessWidget {
  const _SignupNavBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => AppNavigator.navigate(AppRoutes.login),
          child: const SizedBox(
            width: 48,
            height: 48,
            child: Icon(Icons.arrow_back, color: Colors.white, size: 22),
          ),
        ),
        Expanded(
          child: Text(
            'WiseCare',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 32 / 24,
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}

class _SignupLogoSection extends StatelessWidget {
  const _SignupLogoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 73,
              height: 73,
              decoration: const BoxDecoration(
                color: Color(0x33FF6933),
                shape: BoxShape.circle,
              ),
            ),
            SvgImage(
              Assets.icons.appIconSvg.path,
              width: 44,
              height: 44,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Welcome to your care community',
          style: GoogleFonts.lexend(
            color: const Color(0xFFCBD5E1),
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 28 / 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ── Form Card ─────────────────────────────────────────────────────────────────

class _SignupCard extends StatelessWidget {
  const _SignupCard({
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.mobileController,
    required this.cityController,
    required this.fullNameFocusNode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.mobileFocusNode,
    required this.cityFocusNode,
    required this.onCreateAccount,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController mobileController;
  final TextEditingController cityController;
  final FocusNode fullNameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode mobileFocusNode;
  final FocusNode cityFocusNode;
  final VoidCallback onCreateAccount;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -_SignupDimens.cardOverlap),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: _SignupDimens.cardHorizontalMargin,
        ),
        padding: const EdgeInsets.all(_SignupDimens.cardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_SignupDimens.cardRadius),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 25,
              offset: Offset(0, 20),
            ),
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 10,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SignupCardHeading(),
            const SizedBox(height: _SignupDimens.cardGap),
            const _SignupRoleSelector(),
            const SizedBox(height: _SignupDimens.cardGap),
            _SignupFullNameField(
              controller: fullNameController,
              focusNode: fullNameFocusNode,
            ),
            const SizedBox(height: _SignupDimens.fieldGap),
            _SignupEmailField(
              controller: emailController,
              focusNode: emailFocusNode,
            ),
            const SizedBox(height: _SignupDimens.fieldGap),
            _SignupPasswordField(
              controller: passwordController,
              focusNode: passwordFocusNode,
            ),
            const SizedBox(height: _SignupDimens.fieldGap),
            _SignupMobileField(
              controller: mobileController,
              focusNode: mobileFocusNode,
            ),
            const SizedBox(height: _SignupDimens.fieldGap),
            _SignupCityField(
              controller: cityController,
              focusNode: cityFocusNode,
            ),
            const SizedBox(height: _SignupDimens.cardGap),
            _SignupCreateButton(onCreateAccount: onCreateAccount),
            const SizedBox(height: _SignupDimens.cardGap),
            const _SignupLoginLink(),
          ],
        ),
      ),
    );
  }
}

class _SignupCardHeading extends StatelessWidget {
  const _SignupCardHeading();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Create your account',
      style: GoogleFonts.lexend(
        color: const Color(0xFF0F172A),
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
      ),
      textAlign: TextAlign.center,
    );
  }
}

// ── Role Selector ─────────────────────────────────────────────────────────────

class _SignupRoleSelector extends StatelessWidget {
  const _SignupRoleSelector();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who are you?',
          style: GoogleFonts.lexend(
            color: const Color(0xFF334155),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 28 / 18,
          ),
        ),
        const SizedBox(height: 12),
        const _SignupRoleToggle(),
      ],
    );
  }
}

class _SignupRoleToggle extends StatelessWidget {
  const _SignupRoleToggle();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignupProvider>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SignupRoleRow(
          label: "I'm a senior",
          isSelected: provider.role == UserRole.sevakar,
          onTap: () => provider.selectRole(UserRole.sevakar),
        ),
        const SizedBox(height: 12),
        _SignupRoleRow(
          label: "I'm a family member",
          isSelected: provider.role == UserRole.familyMember,
          onTap: () => provider.selectRole(UserRole.familyMember),
        ),
      ],
    );
  }
}

class _SignupRoleRow extends StatelessWidget {
  const _SignupRoleRow({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOut,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(24),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.lexend(
              color: isSelected ? const Color(0xFFFF6933) : const Color(0xFF64748B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 24 / 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// ── Form Fields ───────────────────────────────────────────────────────────────

class _SignupFullNameField extends StatelessWidget {
  const _SignupFullNameField({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SignupProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SignupFieldLabel(label: 'Full Name'),
        const SizedBox(height: 8),
        TextFormField(
          key: const ValueKey<String>('signup_full_name'),
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          autofillHints: const [AutofillHints.name],
          onChanged: (value) => provider.fullName = value,
          style: _SignupFieldStyle.inputText,
          decoration: _SignupFieldStyle.inputDecoration(
            hintText: 'Ex: Rajesh Kumar',
            hintFontSize: 18,
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class _SignupEmailField extends StatelessWidget {
  const _SignupEmailField({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SignupProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SignupFieldLabel(label: 'Email Address'),
        const SizedBox(height: 8),
        TextFormField(
          key: const ValueKey<String>('signup_email'),
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          autofillHints: const [AutofillHints.email],
          onChanged: (value) => provider.email = value,
          style: _SignupFieldStyle.inputText,
          decoration: _SignupFieldStyle.inputDecoration(
            hintText: 'name@example.com',
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class _SignupPasswordField extends StatelessWidget {
  const _SignupPasswordField({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignupProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SignupFieldLabel(label: 'Password'),
        const SizedBox(height: 8),
        TextFormField(
          key: const ValueKey<String>('signup_password'),
          controller: controller,
          focusNode: focusNode,
          obscureText: !provider.isPasswordVisible,
          autocorrect: false,
          autofillHints: const [AutofillHints.newPassword],
          onChanged: (value) => provider.password = value,
          style: _SignupFieldStyle.inputText,
          decoration: _SignupFieldStyle.inputDecoration(
            hintText: 'At least 8 characters',
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
            suffixIcon: GestureDetector(
              onTap: () => provider.togglePasswordVisibility(),
              child: Icon(
                provider.isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: const Color(0xFF94A3B8),
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SignupMobileField extends StatelessWidget {
  const _SignupMobileField({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SignupProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SignupFieldLabel(label: 'Mobile Number'),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              height: 60,
              width: 84,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(_SignupDimens.inputRadius),
              ),
              alignment: Alignment.center,
              child: Text(
                '+91',
                style: GoogleFonts.lexend(
                  color: const Color(0xFF0F172A),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 60,
                child: TextFormField(
                  key: const ValueKey<String>('signup_mobile'),
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (value) => provider.mobile = value,
                  style: _SignupFieldStyle.inputText,
                  decoration: _SignupFieldStyle.inputDecoration(
                    hintText: '9876543210',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SignupCityField extends StatelessWidget {
  const _SignupCityField({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SignupProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SignupFieldLabel(label: 'City'),
        const SizedBox(height: 8),
        TextFormField(
          key: const ValueKey<String>('signup_city'),
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.streetAddress,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          onChanged: (value) => provider.selectCity(value.trim()),
          style: _SignupFieldStyle.inputText,
          decoration: _SignupFieldStyle.inputDecoration(
            hintText: 'e.g. Chennai, Mumbai',
            prefixIcon: const Icon(
              Icons.location_on_outlined,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

// ── CTA Button ────────────────────────────────────────────────────────────────

class _SignupCreateButton extends StatelessWidget {
  const _SignupCreateButton({required this.onCreateAccount});

  final VoidCallback onCreateAccount;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignupProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (provider.errorMessage != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              provider.errorMessage!,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
        ],
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6933),
                borderRadius: BorderRadius.circular(_SignupDimens.buttonRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4DFF6933),
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0x4DFF6933),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: provider.isLoading ? null : onCreateAccount,
                borderRadius: BorderRadius.circular(_SignupDimens.buttonRadius),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: provider.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Create Account',
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 28 / 20,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Sign-In Link ───────────────────────────────────────────────────────────────

class _SignupLoginLink extends StatelessWidget {
  const _SignupLoginLink();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.navigate(AppRoutes.login),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.lexend(
            color: const Color(0xFF475569),
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 28 / 18,
          ),
          children: [
            const TextSpan(text: 'Already have an account? '),
            TextSpan(
              text: 'Sign In',
              style: GoogleFonts.lexend(
                color: const Color(0xFFFF6933),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 28 / 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _SignupFooter extends StatelessWidget {
  const _SignupFooter();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -_SignupDimens.cardOverlap),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_outline,
                  color: Color(0xFF64748B),
                  size: 14,
                ),
                const SizedBox(width: 8),
                Text(
                  'Your data is safe and secure',
                  style: GoogleFonts.lexend(
                    color: const Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared helpers ────────────────────────────────────────────────────────────

class _SignupFieldLabel extends StatelessWidget {
  const _SignupFieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.lexend(
        color: const Color(0xFF0F172A),
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 28 / 18,
      ),
    );
  }
}

abstract class _SignupFieldStyle {
  static TextStyle get inputText => GoogleFonts.lexend(
        color: const Color(0xFF0F172A),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static InputDecoration inputDecoration({
    required String hintText,
    double hintFontSize = 16,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.lexend(
        color: const Color(0xFF6B7280),
        fontSize: hintFontSize,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_SignupDimens.inputRadius),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_SignupDimens.inputRadius),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_SignupDimens.inputRadius),
        borderSide: const BorderSide(color: Color(0xFFFF6933), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    );
  }
}
