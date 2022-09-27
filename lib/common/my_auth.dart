import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happyo/widgets/login_modal.dart';

class MyAuth {
  static Future<void> onlyRegisteredUserAction({
    required BuildContext context,
    required void Function()? action,
  }) async {
    if (FirebaseAuth.instance.currentUser == null) {
      final user = await LoginModal.showLoginModal(context);
      if (user == null) return;
    }
    action?.call();
  }
}
