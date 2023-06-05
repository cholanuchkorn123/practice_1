import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_freezed/constant/constant.dart';
import 'package:riverpod_freezed/features/tweet/view/Create_tweet_Page.dart';

import '../../../theme/pallete.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final appBar = UIconstant.appbar();

  void onPageChange(int index) => setState(() {
        _page = index;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: IndexedStack(
          index: _page,
          children: UIconstant.pageScreen,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, CreateTweetPage.route()),
          child: const Icon(
            Icons.add,
            color: Pallete.whiteColor,
            size: 28,
          ),
        ),
        bottomNavigationBar: CupertinoTabBar(
            currentIndex: _page,
            onTap: onPageChange,
            backgroundColor: Pallete.backgroundColor,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _page == 0
                      ? AssetsConstants.homeFilledIcon
                      : AssetsConstants.homeOutlinedIcon,
                  color: Pallete.whiteColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsConstants.searchIcon,
                  color: Pallete.whiteColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  _page == 2
                      ? AssetsConstants.notifFilledIcon
                      : AssetsConstants.notifOutlinedIcon,
                  color: Pallete.whiteColor,
                ),
              ),
            ]));
  }
}
