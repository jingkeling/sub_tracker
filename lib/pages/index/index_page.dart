import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sub_tracker/pages/home/home_page.dart';
import 'package:sub_tracker/pages/list/list_page.dart';
import 'package:sub_tracker/pages/mine/mine_page.dart';

class IndexPage extends HookWidget {
  final String title;
  // title传参
  const IndexPage({Key? key, this.title = 'demo'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = [
      {
        'label': '首页',
        'icon': Icons.home,
        // 对应的页面
        'page': const HomePage(),
      },
      {
        'label': '列表',
        'icon': Icons.business,
        'page': const ListPage(),
      },
      {
        'label': '我的',
        'icon': Icons.school,
        'page': const MinePage(),
      }
    ];
    final currentIndex = useState(0);

    return Center(
        child: Scaffold(
            body: list[currentIndex.value]['page'] as Widget,
            bottomNavigationBar: CupertinoTabBar(
                items: list.map((e) => BottomNavigationBarItem(icon: Icon(e['icon'] as IconData))).toList(),
                currentIndex: currentIndex.value,
                onTap: (index) {
                  currentIndex.value = index;
                })));
  }
}
