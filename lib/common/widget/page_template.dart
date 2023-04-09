import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';

class PageTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const PageTemplate({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions ?? [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(standardGap),
        child: child,
      ),
    );
  }
}
