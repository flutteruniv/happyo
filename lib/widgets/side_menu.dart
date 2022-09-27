import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happyo/common/my_styles.dart';
import 'package:happyo/common/routes.dart';
import 'package:nil/nil.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: Column(
        children: [
          if (currentUser != null)
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(),
              accountName: Text(
                "${currentUser.displayName}",
                style: MyStyles.defaultText(context),
              ),
              accountEmail: Text(
                "${currentUser.email}",
                style: MyStyles.defaultText(context),
              ),
            ),
          if (currentUser == null)
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
              ),
              accountName: Text('匿名ユーザー', style: MyStyles.defaultText(context)),
              accountEmail: nil,
            ),
          TextButton(
            onPressed: () {
              Routes.pop(context);
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
