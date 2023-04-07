import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

class GetReadyPage extends StatefulWidget {
  const GetReadyPage({super.key});

  static const routeName = '/getReady';

  @override
  State<GetReadyPage> createState() => _GetReadyPageState();
}

class _GetReadyPageState extends State<GetReadyPage> {
  var countdown = '3';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        countdown = '2';
      });
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        countdown = '1';
      });
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        countdown = 'Go!';
      });
    });
    Future.delayed(Duration(seconds: 4), () {
      context.push(QuestionPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'The game is about to start',
      child: Center(
        child: Column(
          children: [
            Text('Get ready', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: standardGap),
            Text(countdown, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
