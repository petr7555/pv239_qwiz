import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildSmallStar(),
            _buildStar(size: 100),
            _buildSmallStar(),
          ],
        ),
        Text('Welcome to Qwiz!', style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }

  Widget _buildStar({required double size}) {
    return Icon(Icons.star, color: Colors.yellow, size: size);
  }

  Widget _buildSmallStar() {
    return Padding(
      padding: EdgeInsets.only(bottom: smallGap),
      child: _buildStar(size: 50),
    );
  }
}
