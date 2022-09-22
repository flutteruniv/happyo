import 'package:flutter/material.dart';
import 'package:happyo/common/my_styles.dart';
import 'package:happyo/common/routes.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(),
            accountName: Text('アカウント名', style: MyStyles.defaultText(context)),
            accountEmail: Text('メールアドレス', style: MyStyles.defaultText(context)),
          ),
          TextButton(
            onPressed: () {
              Routes.pushNamed(context, Routes.profile);
            },
            child: ListTile(
              leading: Icon(
                Icons.account_box_rounded,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text('プロフィール', style: MyStyles.defaultText(context)),
            ),
          )
        ],
      ),
    );
  }
}
