/// API path constants. Aligned with docs/API_REFERENCE.md.
class Endpoints {
  Endpoints._();

  // ── Auth (no token required) ──────────────────────────────────────────────
  static const String authSignup = '/auth/signup';
  static const String authSignin = '/auth/signin';
  static const String authRefresh = '/auth/refresh';
  static const String authSignout = '/auth/signout';

  // ── User ──────────────────────────────────────────────────────────────────
  /// GET /users/me — logged-in user's full profile.
  static const String usersMe = '/users/me';

  // ── Vitals & Risk ─────────────────────────────────────────────────────────
  /// GET /vitals/latest/{userId}
  static String vitalsLatest(String userId) => '/vitals/latest/$userId';

  /// GET /risk/{userId}
  static String risk(String userId) => '/risk/$userId';

  // ── Alerts ────────────────────────────────────────────────────────────────
  /// GET /alerts/user/{userId}
  static String alertsForUser(String userId) => '/alerts/user/$userId';

  /// PATCH /alerts/{alertId}/resolve
  static String resolveAlert(String alertId) => '/alerts/$alertId/resolve';

  // ── Companion Chat ────────────────────────────────────────────────────────
  static const String companionChat = '/companion/chat';
  static const String companionVoice = '/companion/voice';

  // ── Service Requests ──────────────────────────────────────────────────────
  /// GET /service-requests — list filtered by caller's role.
  static const String serviceRequests = '/service-requests';

  /// GET /service-requests/{requestId} — single request by id.
  static String serviceRequest(String requestId) =>
      '/service-requests/$requestId';

  /// PATCH /service-requests/{requestId}/status
  static String serviceRequestStatus(String requestId) =>
      '/service-requests/$requestId/status';

  /// PATCH /service-requests/{requestId}/assign — ADMIN only.
  static String serviceRequestAssign(String requestId) =>
      '/service-requests/$requestId/assign';

  // ── Meds ──────────────────────────────────────────────────────────────────
  /// GET /meds/schedule?date=YYYY-MM-DD
  static const String medsSchedule = '/meds/schedule';

  /// POST /meds/medications/:id/taken
  static String medsTaken(String medicationId) =>
      '/meds/medications/$medicationId/taken';

  /// POST /meds/refill-requests
  static const String medsRefillRequests = '/meds/refill-requests';

  // ── SOS ───────────────────────────────────────────────────────────────────
  /// POST /sos — ELDERLY only. No body.
  static const String sos = '/sos';

  // ── Notifications ─────────────────────────────────────────────────────────
  static const String notificationsRegister = '/notifications/register';

  // ── Admin ─────────────────────────────────────────────────────────────────
  static const String adminStats = '/admin/stats';
  static const String adminAlerts = '/admin/alerts';
  static const String adminUsers = '/admin/users';
  static String adminUser(String userId) => '/admin/users/$userId';
  static const String adminCreateAgent = '/admin/users/agent';
  static String adminUserStatus(String userId) =>
      '/admin/users/$userId/status';
  static const String adminAgentsAvailable = '/admin/agents/available';
}
