import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/enums/app_enums.dart';
import 'package:wisecare_frontend/gen/assets.gen.dart';
import 'package:wisecare_frontend/navigation/app_navigator.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/provider/login_provider.dart';
import 'package:wisecare_frontend/utils/theme/colors/app_color.dart';
import 'package:wisecare_frontend/utils/theme/theme_manager.dart';
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
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final viewHeight = MediaQuery.of(context).size.height - padding.bottom;
    return Scaffold(
      backgroundColor: Skin.color(Co.warmBackground),
      body: Padding(
        padding: EdgeInsets.only(
          left: padding.left,
          right: padding.right,
          bottom: padding.bottom,
        ),
        child: ValueListenableBuilder<AppThemeMode>(
          valueListenable: Skin.themeMode,
          builder: (_, __, ___) => Consumer<LoginProvider>(
            builder: (context, provider, _) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: viewHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        behavior: HitTestBehavior.opaque,
                        child: const _LoginHeader(),
                      ),
                      const SizedBox(height: _LoginDimens.cardOverlap),
                      _LoginCard(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        emailFocusNode: _emailFocusNode,
                        passwordFocusNode: _passwordFocusNode,
                        onSignIn: () => _handleSignIn(context),
                      ),
                      GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        behavior: HitTestBehavior.opaque,
                        child: const SizedBox(height: _LoginDimens.cardOverlap),
                      ),
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

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topInset + 32,
        bottom: 48,
      ),
      decoration: BoxDecoration(
        color: Skin.color(Co.loginHeader),
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
            color: Skin.color(Co.iconShield),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Skin.color(Co.iconShield).withValues(alpha: 0.5),
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
          style: TextStyle(
            color: Skin.color(Co.headerSubtitle),
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
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.onSignIn,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(_LoginDimens.cardPadding),
      decoration: BoxDecoration(
        color: Skin.color(Co.cardSurface),
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
          _LoginEmailField(
            emailController: emailController,
            focusNode: emailFocusNode,
          ),
          const SizedBox(height: _LoginDimens.cardGap),
          _LoginPasswordField(
            passwordController: passwordController,
            focusNode: passwordFocusNode,
          ),
          const SizedBox(height: _LoginDimens.cardGap),
          _LoginSignInButton(onSignIn: onSignIn),
          const SizedBox(height: _LoginDimens.cardGap),
          const _LoginDivider(),
          const SizedBox(height: _LoginDimens.cardGap),
          const _LoginGoogleButton(),
          const SizedBox(height: _LoginDimens.cardGap),
          const _LoginSignUpLink(),
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
        // Text(
        //   'नमस्ते 👋',
        //   style: TextStyle(
        //     color: Skin.color(Co.onBackground),
        //     fontSize: 36,
        //     fontWeight: FontWeight.w700,
        //     height: 45 / 36,
        //   ),
        //   textAlign: TextAlign.center,
        // ),
        // const SizedBox(height: 8),
        Text(
          'Please sign in to continue',
          style: TextStyle(
            color: Skin.color(Co.textMuted),
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
        color: Skin.color(Co.cardSurface),
        border: Border.all(color: Skin.color(Co.outline), width: 2),
        borderRadius: BorderRadius.circular(_LoginDimens.buttonRadius),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgImage(
            Assets.icons.googleLogo.path,
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 12),
          Text(
            'Sign in with Google',
            style: TextStyle(
              color: Skin.color(Co.onBackground),
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
            color: Skin.color(Co.outline),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              color: Skin.color(Co.textMuted),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 24 / 16,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Skin.color(Co.outline),
          ),
        ),
      ],
    );
  }
}

class _LoginEmailField extends StatelessWidget {
  const _LoginEmailField({
    required this.emailController,
    required this.focusNode,
  });

  final TextEditingController emailController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Email',
          style: TextStyle(
            color: Skin.color(Co.onBackground),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 28 / 18,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          key: const ValueKey<String>('login_email'),
          controller: emailController,
          focusNode: focusNode,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          autofillHints: const [AutofillHints.email],
          onChanged: (value) => provider.email = value,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            filled: true,
            fillColor: Skin.color(Co.cardSurface),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_LoginDimens.inputRadius),
              borderSide: BorderSide(color: Skin.color(Co.outline)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_LoginDimens.inputRadius),
              borderSide: BorderSide(color: Skin.color(Co.outline)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginPasswordField extends StatelessWidget {
  const _LoginPasswordField({
    required this.passwordController,
    required this.focusNode,
  });

  final TextEditingController passwordController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Password',
          style: TextStyle(
            color: Skin.color(Co.onBackground),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 28 / 18,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          key: const ValueKey<String>('login_password'),
          controller: passwordController,
          focusNode: focusNode,
          obscureText: true,
          autocorrect: false,
          autofillHints: const [AutofillHints.password],
          onChanged: (value) => provider.password = value,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            filled: true,
            fillColor: Skin.color(Co.cardSurface),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_LoginDimens.inputRadius),
              borderSide: BorderSide(color: Skin.color(Co.outline)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_LoginDimens.inputRadius),
              borderSide: BorderSide(color: Skin.color(Co.outline)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
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
                color: Skin.color(Co.primary),
                borderRadius: BorderRadius.circular(_LoginDimens.buttonRadius),
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
                borderRadius: BorderRadius.circular(_LoginDimens.buttonRadius),
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

class _LoginSignUpLink extends StatelessWidget {
  const _LoginSignUpLink();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.navigate(AppRoutes.signup),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: Skin.color(Co.textMuted),
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 28 / 18,
          ),
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Skin.color(Co.primary),
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
