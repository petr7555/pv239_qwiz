import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';

class PageTemplate extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  final bool scrollable;

  const PageTemplate({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final paddedChild = Padding(
      padding: EdgeInsets.all(standardGap),
      child: child,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions ?? [],
      ),
      body: scrollable
          ? SingleChildScrollView(
              child: paddedChild,
            )
          : paddedChild,
    );
  }
}
