import 'package:flutter/material.dart';

/// Global navigator key, so we can navigate without a BuildContext
/// (used when the token expires inside the Dio interceptor).
class AppNavigator {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
}
