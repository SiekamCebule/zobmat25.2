import 'package:flutter/material.dart';

class AboutPageCard extends StatelessWidget {
  const AboutPageCard({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 10, bottom: 7),
            child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 15),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
