import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(buttonHeight),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
