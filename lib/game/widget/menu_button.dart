import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final String route;

  const MenuButton({
    super.key,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(buttonHeight), // fromHeight use double.infinity as width and 40 is the height
      ),
      onPressed: () => context.go(route),
      child: Text(label),
    );
  }
}
