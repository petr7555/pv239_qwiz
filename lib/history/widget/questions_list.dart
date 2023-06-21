import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/game/model/question.dart';
import 'package:pv239_qwiz/game/widget/question_options.dart';
import 'package:pv239_qwiz/game/widget/question_page.dart';

class QuestionsList extends StatelessWidget {
  final List<Question> questions;
  final String opponentId;

  const QuestionsList({
    super.key,
    required this.questions,
    required this.opponentId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final userId = context.read<AuthCubit>().userId;

        return ExpansionTile(
          childrenPadding: EdgeInsets.only(top: smallGap),
          title: Text(question.question, style: Theme.of(context).textTheme.titleMedium),
          children: [
            QuestionOptions(
              stateOfQuestion: StateOfQuestion.showingResult,
              question: question,
              userId: userId,
              opponentId: opponentId,
              compactLayout: true,
            ),
          ],
        );
      },
    );
  }
}
