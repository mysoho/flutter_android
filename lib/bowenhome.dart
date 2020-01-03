import 'package:flutter/material.dart';

import 'bowen/bowenpage.dart';
import 'bowen/gongzhongpage.dart';
import 'bowen/mypage.dart';
import 'bowen/tixipage.dart';
import 'bowen/xiangmupage.dart';

class BoWenHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoWenHomePageState();
}

class _BoWenHomePageState extends State<BoWenHomePage>  with SingleTickerProviderStateMixin{
  int _selectedIndex=0;
  var _pageController=new PageController(initialPage:0);
  var pages=<Widget>[ BowenPage(),
    XiangmuPage(),
    TixiPage(),
    MyPage(),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      floatingActionButton: _floatingActionButton,
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('博文')),
        BottomNavigationBarItem(icon: Icon(Icons.navigation),title: Text('项目')),
        BottomNavigationBarItem(icon: Icon(Icons.spa),title: Text('体系')),
        BottomNavigationBarItem(icon: Icon(Icons.contact_mail),title: Text('我的')),
      ],
        currentIndex: _selectedIndex,//当前选中下标
        type: BottomNavigationBarType.fixed,//显示模式
        fixedColor: Colors.redAccent,//选中颜色
        onTap: _onItemTapped, //点击事件
      ),
      body: new PageView.builder(
        onPageChanged: _pageChange,
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          return pages.elementAt(_selectedIndex);
        },
      ),
    );
  }
  void _onItemTapped(int index){
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
  void _pageChange(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
}
