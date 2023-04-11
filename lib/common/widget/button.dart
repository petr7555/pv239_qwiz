import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(buttonHeight),
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
