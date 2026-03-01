import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:wisecare_frontend/navigation/routes.dart';

/// Redirect logic. After splash init, redirect to home.
/// Can be extended for auth gates (e.g. redirect to login if not authenticated).
class RedirectionService {
  RedirectionService._();

  /// Called when splash has finished initializing. Navigate to home.
  static void redirectAfterSplash(BuildContext context) {
    context.go(AppRoutes.home.path);
  }
}
