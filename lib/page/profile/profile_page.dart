import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happyo/common/my_syles.dart';
import 'package:happyo/page/login_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'プロフィール',
          style: MyStyles.defaultText(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            AppInfoBlock(),
            TermsInfoBlock(),
            AccountBlock(),
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
          Text(
            'ユーザー名',
            style: MyStyles.defaultText(context),
          ),
        ],
      ),
    );
  }
}

class GuestProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
          ),
          Text(
            'ゲスト',
            style: MyStyles.defaultText(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  '新規登録',
                  // style: MyStyles.defaultText(context),
                ),
                style: MyStyles.defaultButton(context),
              ),
              TextButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  builder: (context) {
                    return login_page();
                  },
                ),
                child: Text(
                  'ログイン',
                ),
                style: MyStyles.accentButton(context),
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.3),
          bottom: BorderSide(width: 0.5),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
        textScaleFactor: 1.1,
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
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
          child: ListTile(
            title: Text(
              'お知らせ',
              style: MyStyles.defaultText(context),
            ),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: ListTile(
            trailing: Icon(Icons.chevron_right_rounded),
            title: Text(
              'ヘルプセンター',
              style: MyStyles.defaultText(context),
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: ListTile(
            title: Text(
              'お問合せ/ご意見・ご要望',
              style: MyStyles.defaultText(context),
            ),
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
          child: ListTile(
            title: Text(
              '利用規約',
              style: MyStyles.defaultText(context),
            ),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: ListTile(
            title: Text(
              '個人情報保護',
              style: MyStyles.defaultText(context),
            ),
            trailing: Icon(Icons.chevron_right_rounded),
          ),
        ),
      ],
    );
  }
}

class AccountBlock extends StatelessWidget {
  const AccountBlock({Key? key}) : super(key: key);

  Future<void> logout() async {
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }

    return FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoBlockHeader(text: 'アカウント'),
        TextButton(
          onPressed: () {
            logout();
          },
          child: ListTile(
            title: Text(
              'ログアウト',
              style: MyStyles.defaultText(context),
            ),
          ),
        ),
      ],
    );
  }
}
