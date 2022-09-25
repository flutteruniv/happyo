import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happyo/widgets/login_modal.dart';

class MyAuth {
  static void onlyRegisteredUserAction({
    required BuildContext context,
    required void Function()? action,
  }) {
    if (FirebaseAuth.instance.currentUser == null) {
      LoginModal.showLoginModal(context);
    } else {
      action?.call();
    }
  }
}
