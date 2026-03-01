import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/gen/assets.gen.dart';
import 'package:wisecare_frontend/provider/login_provider.dart';
import 'package:wisecare_frontend/widgets/common/svg_image.dart';

part 'login_functions.dart';
part 'login_variables.dart';

/// Login screen: email/password sign-in, design-only Google button.
/// Follows [NEW_SCREEN_DEV](docs/NEW_SCREEN_DEV.md).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _LoginColors.bodyBackground,
      body: SafeArea(
        child: Consumer<LoginProvider>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _LoginHeader(),
                    const SizedBox(height: _LoginDimens.cardOverlap),
                    _LoginCard(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      onSignIn: () => _handleSignIn(context),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 64, bottom: 48),
      decoration: const BoxDecoration(
        color: _LoginColors.headerBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_LoginDimens.headerBottomRadius),
          bottomRight: Radius.circular(_LoginDimens.headerBottomRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _LoginLogo(),
          const SizedBox(height: 24),
          const _LoginWelcomeText(),
        ],
      ),
    );
  }
}

class _LoginLogo extends StatelessWidget {
  const _LoginLogo();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: _LoginDimens.logoSize,
          height: _LoginDimens.logoSize,
          decoration: BoxDecoration(
            color: _LoginColors.logoBg,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _LoginColors.logoShadow,
                blurRadius: 0,
                spreadRadius: 4,
              ),
            ],
          ),
        ),
        SvgImage(
          Assets.icons.appIconSvg.path,
          width: 40,
          height: 50,
          color: _LoginColors.primaryOrange,
        ),
      ],
    );
  }
}

class _LoginWelcomeText extends StatelessWidget {
  const _LoginWelcomeText();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome to WiseCare',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.75,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Your health companion',
          style: const TextStyle(
            color: _LoginColors.headerSubtitle,
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

class _LoginCard extends StatelessWidget {
  const _LoginCard({
    required this.emailController,
    required this.passwordController,
    required this.onSignIn,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(_LoginDimens.cardPadding),
      decoration: BoxDecoration(
        color: _LoginColors.cardBackground,
        borderRadius: BorderRadius.circular(_LoginDimens.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _LoginGreeting(),
          const SizedBox(height: _LoginDimens.cardGap),
          const _LoginGoogleButton(),
          const SizedBox(height: _LoginDimens.cardGap),
          const _LoginDivider(),
          const SizedBox(height: _LoginDimens.cardGap),
          _LoginEmailField(emailController: emailController),
          const SizedBox(height: _LoginDimens.cardGap),
          _LoginPasswordField(passwordController: passwordController),
          const SizedBox(height: _LoginDimens.cardGap),
          _LoginSignInButton(onSignIn: onSignIn),
          const SizedBox(height: _LoginDimens.cardGap),
          const _LoginHelpLink(),
        ],
      ),
    );
  }
}

class _LoginGreeting extends StatelessWidget {
  const _LoginGreeting();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'नमस्ते 👋',
          style: const TextStyle(
            color: _LoginColors.textDark,
            fontSize: 36,
            fontWeight: FontWeight.w700,
            height: 45 / 36,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Please sign in to continue',
          style: const TextStyle(
            color: _LoginColors.textMuted,
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

class _LoginGoogleButton extends StatelessWidget {
  const _LoginGoogleButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: _LoginColors.cardBackground,
        border: Border.all(color: _LoginColors.border, width: 2),
        borderRadius: BorderRadius.circular(_LoginDimens.buttonRadius),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _LoginColors.textMuted,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Sign in with Google',
            style: const TextStyle(
              color: _LoginColors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 28 / 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginDivider extends StatelessWidget {
  const _LoginDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: _LoginColors.border,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: const TextStyle(
              color: _LoginColors.textMuted,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 24 / 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: _LoginColors.border,
          ),
        ),
      ],
    );
  }
}

class _LoginEmailField extends StatelessWidget {
  const _LoginEmailField({required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            color: _LoginColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 28 / 18,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: _LoginColors.cardBackground,
            borderRadius: BorderRadius.circular(_LoginDimens.inputRadius),
            border: Border.all(color: _LoginColors.border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            autofillHints: const [AutofillHints.email],
            onChanged: (value) => provider.email = value,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginPasswordField extends StatelessWidget {
  const _LoginPasswordField({required this.passwordController});

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            color: _LoginColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 28 / 18,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: _LoginColors.cardBackground,
            borderRadius: BorderRadius.circular(_LoginDimens.inputRadius),
            border: Border.all(color: _LoginColors.border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            controller: passwordController,
            obscureText: true,
            autocorrect: false,
            autofillHints: const [AutofillHints.password],
            onChanged: (value) => provider.password = value,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginSignInButton extends StatelessWidget {
  const _LoginSignInButton({required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (provider.errorMessage != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              provider.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          ),
        ],
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 64,
              decoration: BoxDecoration(
                color: _LoginColors.primaryOrange,
                borderRadius:
                    BorderRadius.circular(_LoginDimens.buttonRadius),
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
                onTap: provider.isLoading ? null : onSignIn,
                borderRadius:
                    BorderRadius.circular(_LoginDimens.buttonRadius),
                child: Container(
                  height: 64,
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
                      : const Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 28 / 20,
                            letterSpacing: 0.5,
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

class _LoginHelpLink extends StatelessWidget {
  const _LoginHelpLink();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Text(
        'Need help signing in?',
        style: TextStyle(
          color: _LoginColors.primaryOrange,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 28 / 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
