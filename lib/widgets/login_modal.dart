import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginModal {
  static Future<User?> showLoginModal(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        var _screenSize = MediaQuery.of(context).size;
        return Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: _screenSize.height * 0.10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HAPPY',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      'O',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _screenSize.height * 0.10,
                ),
                SignInButton(
                  LoginModal._isDarkMode(context)
                      ? Buttons.GoogleDark
                      : Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () async {
                    await LoginModal._signInWithGoogle();
                    Navigator.pop(context);
                  },
                ),
                SignInButton(
                  LoginModal._isDarkMode(context)
                      ? Buttons.AppleDark
                      : Buttons.Apple,
                  text: "Sign up with Apple",
                  onPressed: () async {
                    await LoginModal._signInWithApple();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
    return null;
  }

  // Google
  static Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Apple
  static Future<UserCredential> _signInWithApple() async {
    // Obtain the AuthorizationCredentialAppleID
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Create a new OAthCredential
    OAuthProvider oauthProvider = OAuthProvider('apple.com');
    final credential = oauthProvider.credential(
      accessToken: appleCredential.authorizationCode,
      idToken: appleCredential.identityToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static bool _isDarkMode(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    return brightness == Brightness.dark;
  }
}
