import 'package:flutter/material.dart';
import 'package:happyo/page/home_page.dart';
import 'package:happyo/page/profile/profile_page.dart';
import 'package:happyo/page/seach_page.dart';

class NavBarItem {
  const NavBarItem(this.iconData, this.text);
  final IconData iconData;
  final String text;
}

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int index = 0;
  final _body = [HomePage(), SearchPage(), ProfilePage()];

  final navBarItemList = const <NavBarItem>[
    NavBarItem(Icons.home, 'ホーム'),
    NavBarItem(Icons.search, '検索'),
    // NavBarItem(Icons.interests_outlined, '特集'),
    // NavBarItem(Icons.mail_outline_outlined, 'メッセージ'),
    NavBarItem(Icons.account_circle_outlined, 'マイページ'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body[index],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          showSelectedLabels: true,
          unselectedItemColor: Theme.of(context).colorScheme.onBackground,
          selectedItemColor: Theme.of(context).colorScheme.tertiary,
          items: navBarItemList
              .map((NavBarItem navBarItem) => BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    icon: Icon(navBarItem.iconData),
                    label: navBarItem.text,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
