import 'package:flutter/material.dart';
import 'package:flutter_news/components/appbar.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/utils/index.dart';

import 'package:flutter_news/views/account/index.dart';
import 'package:flutter_news/views/bookmarks/index.dart';
import 'package:flutter_news/views/category/index.dart';
import 'package:flutter_news/views/main/index.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  int _pageNum = 0;
  final List<String> _tabTitles = [
    'Welcome',
    'Category',
    'Bookmarks',
    'Account'
  ];

  PageController? _pageController;

  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.home,
          color: ThemeColors.tabBarElement,
        ),
        activeIcon:
            Icon(Iconfont.home, color: ThemeColors.secondaryElementText),
        label: 'main',
        backgroundColor: ThemeColors.primaryBackground),
    const BottomNavigationBarItem(
      icon: Icon(
        Iconfont.grid,
        color: ThemeColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.grid,
        color: ThemeColors.secondaryElementText,
      ),
      label: 'category',
      backgroundColor: ThemeColors.primaryBackground,
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Iconfont.tag,
        color: ThemeColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.tag,
        color: ThemeColors.secondaryElementText,
      ),
      label: 'tag',
      backgroundColor: ThemeColors.primaryBackground,
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Iconfont.me,
        color: ThemeColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.me,
        color: ThemeColors.secondaryElementText,
      ),
      label: 'my',
      backgroundColor: ThemeColors.primaryBackground,
    ),
  ];

  void _handleNavBarTap(int index) {
    _pageController!.jumpToPage(index);
  }

  void _handlePageChanged(int page) {
    setState(() {
      _pageNum = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageNum);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController!.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar() {
    return TransparentAppBar(
        title: Text(
          _tabTitles[_pageNum],
          style: TextStyle(
            color: ThemeColors.primaryText,
            fontFamily: 'Montserrat',
            fontSize: duSetFontSize(18.0),
            fontWeight: FontWeight.w600,
          ),
        ),
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: ThemeColors.primaryText,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: ThemeColors.primaryText,
            ),
            onPressed: () {},
          )
        ]);
  }

  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        MainPage(),
        CategoryPage(),
        BookmarksPage(),
        AccountPage(),
      ],
      controller: _pageController,
      onPageChanged: _handlePageChanged,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: _bottomTabs,
      currentIndex: _pageNum,
      type: BottomNavigationBarType.fixed,
      onTap: _handleNavBarTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
