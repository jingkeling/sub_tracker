import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCards = useState([]);
    final list = useState([]);

    initList() {
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

      list.value.addAll([
        {
          "title": 'Amazon Prime',
          "subTitle": 'May 09',
          "icon":
              "https://cdn1.iconfinder.com/data/icons/space-travel-flat/340/space_astronomy_system_planet_universe_galaxy_star_jupiter-256.png",
          "price": 12.99,
          "unit_time": "month",
        },
        {
          "title": 'Figma',
          "subTitle": 'May 09',
          "icon": "",
          "price": 10.99,
          "unit_time": "month",
        },
        {
          "title": 'Notion',
          "subTitle": 'May 09',
          "icon": "",
          "price": 2.99,
          "unit_time": "month",
        },
        {
          "title": 'QQ Music',
          "subTitle": 'May 09',
          "icon": "",
          "price": 121.99,
          "unit_time": "month",
        },
        {
          "title": 'Amazon Prime',
          "subTitle": 'May 09',
          "icon": "",
          "price": 12.99,
          "unit_time": "month",
        },
        {
          "title": 'Figma',
          "subTitle": 'May 09',
          "icon": "",
          "price": 10.99,
          "unit_time": "month",
        },
        {
          "title": 'Notion',
          "subTitle": 'May 09',
          "icon": "",
          "price": 2.99,
          "unit_time": "month",
        },
        {
          "title": 'QQ Music',
          "subTitle": 'May 09',
          "icon": "",
          "price": 121.99,
          "unit_time": "month",
        },
      ]);
    }

    useEffect(() {
      initList();
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: Text('dada'),
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Text("2500",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        Text(
                          "/",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text("Month",
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Balance',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              const Text('5000',
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Subscription',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              const Text('5000',
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
                    onTap: () {
                      print("点击了Show all");
                    },
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList.separated(
              itemCount: list.value.length,
              itemBuilder: (context, index) {
                return Container(
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
                          height: 50,
                          width: 50,
                          'https://cdn1.iconfinder.com/data/icons/space-travel-flat/340/space_astronomy_system_planet_universe_galaxy_star_jupiter-256.png'),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list.value[index]["title"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(list.value[index]["subTitle"]),
                        ],
                      ))
                    ],
                  ),
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
