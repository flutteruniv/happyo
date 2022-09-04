import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            AppInfoBlock(),
            TermsInfoBlock(),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  bool isLogin = false;

  @override
  ProfileHeaderState createState() => ProfileHeaderState();
}

class ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLogin) {
      return Column(
        children: [
          UserProfileHeader(),
          ProfileInfoBlock(),
        ],
      );
    } else {
      return GuestProfileHeader();
    }
  }
}

class UserProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
          ),
          const Text('ユーザー名'),
        ],
      ),
    );
  }
}

class GuestProfileHeader extends StatelessWidget {

  Future<UserCredential> signInWithGoogle() async {
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

  Future<void> logout() async {
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }

    return FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
          ),
          const Text('ゲスト'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('新規登録'),
              ),
              TextButton(
                onPressed: () {
                  signInWithGoogle();
                },
                child: const Text('ログイン'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileInfoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoBlockHeader(text: 'プロフィール情報'),
        TextButton(
          onPressed: () {},
          child: const ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text('ユーザー名'),
            trailing: Icon(Icons.edit),
          ),
        ),
        const TextButton(
          onPressed: null,
          child: ListTile(
            leading: Icon(Icons.email),
            title: Text('メールアドレス'),
            trailing: Text('G'),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const ListTile(
            title: Text('退会・Google連携解除'),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
        ),
      ],
    );
  }
}

class InfoBlockHeader extends StatelessWidget {
  String? text;

  InfoBlockHeader({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
      ),
      width: MediaQuery.of(context).size.width,
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class AppInfoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoBlockHeader(text: 'アプリについて'),
        TextButton(
          onPressed: () {},
          child: const ListTile(
            // leading: Icon(Icons.circle),
            title: Text('お知らせ'),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const ListTile(
            trailing: Icon(Icons.chevron_right_rounded),
            title: Text('ヘルプセンター'),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const ListTile(
            title: Text('お問合せ/ご意見・ご要望'),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
        ),
      ],
    );
  }
}

class TermsInfoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoBlockHeader(text: '規約'),
        TextButton(
          onPressed: () {},
          child: const ListTile(
            title: Text('利用規約'),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const ListTile(
            title: Text('個人情報保護'),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
        ),
      ],
    );
  }
}
