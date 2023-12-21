import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateProvider((ref) => 0);
ProviderContainer container = ProviderContainer();

class MinePage extends HookConsumerWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MinePage'),
      ),
      body: Column(
        children: [
          Text(ref.watch(counterProvider).toString()),
          ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state += 1;
              },
              child: const Text('add'))
        ],
      ),
    );
  }
}
