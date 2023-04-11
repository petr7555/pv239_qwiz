import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';

class AppLoaderOverlay extends StatelessWidget {
  final Widget child;

  const AppLoaderOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: JumpingDots(
          color: primaryColor,
          radius: 10,
          numberOfDots: 3,
          animationDuration: Duration(milliseconds: 200),
        ),
      ),
      child: child,
    );
  }
}
