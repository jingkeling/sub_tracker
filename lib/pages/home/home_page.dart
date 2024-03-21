import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sub_tracker/components/AnimationBtn2.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCards = useState([]);
    final list = useState([]);

    initList() async {
      categoryCards.value.addAll([
        {
          "title": "Streaming",
          "bgColor": const Color(0xFFEFF8FF),
          "children": [
            {
              "id": 1,
              // 方形图标有颜色的图标
              "icon": "",
            },
            {
              "id": 2,
              // 方形图标有颜色的图标
              "icon": "",
            },
            {
              "id": 3,
              // 方形图标有颜色的图标
              "icon": "",
            },
          ]
        },
        {
          "title": "Streaming",
          "bgColor": const Color(0xffFCF3EF),
        },
        {
          "title": "Streaming",
          "bgColor": const Color(0xFFEFF1FE),
        },
        {
          "title": "Streaming",
          "bgColor": const Color(0xFFEFF8FF),
        },
      ]);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? res = prefs.getString('subs');
      if (res != null) {
        List list1 = json.decode(res);
        print(list1);
        print('共有 ${list1.length} 条数据');
        list.value = list1;
      }
      return;
    }

    useEffect(() {
      initList();
      return null;
    }, []);

    final _nameController = useTextEditingController(text: '123');
    var _priceController = useTextEditingController(text: '123');
    var _timeController = useTextEditingController(text: '123');

    _addItem() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? res = prefs.getString('subs');
      if (res == null) {
        prefs.setString('subs', json.encode([]));
      } else {
        List newList = json.decode(res);
        print(newList);
        Map map = {
          "timestamp": DateTime.now().millisecondsSinceEpoch,
          "title": _nameController.text,
          "subTitle": "test data",
          "icon":
              "https://cdn1.iconfinder.com/data/icons/space-travel-flat/340/space_astronomy_system_planet_universe_galaxy_star_jupiter-256.png",
          "price": _priceController.text,
          "unit_time": _timeController.text,
        };
        newList.add(map);
        print('添加后共有 ${newList.length} 条数据');
        print(newList);
        print('title是不是字符串');
        print(newList[0]['title'] is String);
        list.value = newList;
        String res1 = json.encode(newList);
        await prefs.setString('subs', res1);
      }
    }

    _showList() async {
      print('点击了Show All');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? res = prefs.getString('subs');
      if (res != null) {
        List list = json.decode(res);
        print(res);
        print('共有 ${list.length} 条数据');
      }
    }

    _delAll() async {
      print('点击了Del All');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('subs');
      list.value = [];
    }

    _showAddModal() {
      HapticFeedback.lightImpact();
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return SafeArea(
              child: Container(
                  height: 500,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "新增订阅",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "订阅名",
                          hintText: "",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "价格",
                          hintText: "",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _timeController,
                        decoration: const InputDecoration(
                          labelText: "周期时间",
                          hintText: "",
                        ),
                      ),
                      const SizedBox(height: 20),
                      // 确认图标，带圆形边框
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          foregroundColor: MaterialStateProperty.all(Colors.black),
                          elevation: MaterialStateProperty.all(20),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        ),
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          _addItem();
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )),
            );
          });
    }

    _goSubEdit(int index) {
      HapticFeedback.lightImpact();
      context.goNamed('sub-edit', extra: {'index': index});
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        title: const Text('dada'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              elevation: MaterialStateProperty.all(20),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            ),
            onPressed: () {
              // context.goNamed('sub_add');
              _showAddModal();
            },
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
        ],
      ),
      body: Container(
        height: 800,
        // padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        child: CustomScrollView(slivers: [
          // 顶部的卡片
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(
                top: 20,
                left: 15,
                right: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: const Color(0xFF020818),
                // 阴影效果
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x00000000).withOpacity(0.58),
                    offset: const Offset(0, 2),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: AspectRatio(
                aspectRatio: 274 / 143,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 10),
                    const Text("Spending",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal, color: Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Text(
                            list.value.isNotEmpty
                                ? list.value
                                    .map((item) => int.parse(item['price']))
                                    .reduce((value, item) => value + item)
                                    .toString()
                                : '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        const Text(
                          "/",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const Text("Month",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Balance',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              Text('5000',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white60,
                          ),
                        ),
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Subscription',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              Text('5000',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Subscriptions Category", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    child: const Text("Show all", style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () async {
                      _showList();
                    },
                  ),
                  GestureDetector(
                    child: const Text("del", style: TextStyle(decoration: TextDecoration.underline)),
                    onTap: () async {
                      _delAll();
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList.separated(
              itemCount: list.value.length,
              itemBuilder: (context, index) {
                return AnimationBtn2(
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                    height: 90,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // color: Colors.red,
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          list.value[index]["icon"],
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list.value[index]["title"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(list.value[index]["subTitle"]),
                          ],
                        )),
                        Text(
                          "\$${list.value[index]["price"]}/${list.value[index]["unit_time"]}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _goSubEdit(index);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
