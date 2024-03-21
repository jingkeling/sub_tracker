import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SubEdit extends HookWidget {
  const SubEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('商品编辑')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('跳转'),
          ),
          //  Image.network('https://image.ddzuwu.com/file/images/246417823c2d4b2d6e311034f126d917.webp'),
        ],
      ),
    );
  }
}
