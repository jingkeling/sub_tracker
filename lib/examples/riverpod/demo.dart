import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider((_) => 0);

void main() => runApp(const ProviderScope(child: MaterialApp(home: Demo())));

class Demo extends ConsumerWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Column(
          children: [
            Text(ref.watch(counterProvider).toString()),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).state += 1;
              },
              child: const Text('Change'),
            ),
          ],
        ),
      ),
    );
  }
}
