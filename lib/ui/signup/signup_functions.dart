part of 'signup_screen.dart';

extension _SignupScreenFunctions on _SignupScreenState {
  void _handleCreateAccount(BuildContext context) {
    final provider = context.read<SignupProvider>();
    provider.fullName = _fullNameController.text.trim();
    provider.email = _emailController.text.trim();
    provider.password = _passwordController.text;
    provider.mobile = _mobileController.text.trim();
    provider.selectCity(_cityController.text.trim());
    provider.signUp();
  }
}
