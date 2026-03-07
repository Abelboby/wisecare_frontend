/// Response payload for POST /auth/signup (201 Created).
/// Fields match the WiseCare Auth API exactly.
class SignupResponseModel {
  const SignupResponseModel({
    required this.accessToken,
    this.refreshToken,
    this.userId,
    this.role,
    this.name,
    this.email,
    this.onboardingStep,
    this.profileComplete,
  });

  final String accessToken;
  final String? refreshToken;
  final String? userId;

  /// `ELDERLY` or `FAMILY`.
  final String? role;
  final String? name;
  final String? email;

  /// Always `BASIC_INFO` for new signups.
  final String? onboardingStep;

  /// Always `false` after signup.
  final bool? profileComplete;

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String?,
      userId: json['userId'] as String?,
      role: json['role'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      onboardingStep: json['onboardingStep'] as String?,
      profileComplete: json['profileComplete'] as bool?,
    );
  }
}
