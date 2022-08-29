import 'package:flutter/material.dart';
import 'package:happyo/common/routes.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(),
            accountName: Text('アカウント名'),
            accountEmail: Text('メールアドレス'),
          ),
          TextButton(
            onPressed: () {
              Routes.pushNamed(context, Routes.profile);
            },
            child: const ListTile(
              leading: Icon(Icons.account_box_rounded),
              title: Text('プロフィール'),
            ),
          )
        ],
      ),
    );
  }
}
