import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomDialog extends ConsumerWidget {
  final Widget? header;
  final String? title;
  final String? description;
  final void Function()? onDone;
  const CustomDialog(
      {super.key,
      required this.header,
      required this.title,
      required this.onDone,
      required this.description});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        header!,
        const SizedBox(
          height: 15,
        ),
        Text(title!,
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize!,
              fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily!,
            )),
        const SizedBox(
          height: 10,
        ),
        Text(description!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 35.0),
                    backgroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent)),
                child:
                    Text('Non', style: Theme.of(context).textTheme.labelLarge)),
            OutlinedButton(
                onPressed: onDone!,
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 35.0),
                    backgroundColor: Colors.greenAccent,
                    side: BorderSide.none),
                child:
                    Text('Oui', style: Theme.of(context).textTheme.labelLarge)),
          ],
        )
      ]),
    ));
  }
}
