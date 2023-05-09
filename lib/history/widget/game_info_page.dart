import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/history/service/history_service.dart';
import 'package:pv239_qwiz/history/widget/player_info.dart';
import 'package:pv239_qwiz/history/widget/question_info.dart';

import '../../game/model/game.dart';

class GameInfoPage extends StatelessWidget {
  final Game game;
  const GameInfoPage({super.key, required this.game});

  static const routeName = '/gameInfo';

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthCubit>().userId;

    final user = game.players[userId]!;
    final opponent = game.players.values.where((element) => element.id != userId).first;

    return PageTemplate(
      title: opponent.displayName != null ? 'Your game vs ${opponent.displayName!}' : "Your game vs unknown opponent",
      child: Row(
        children: [
          PlayerInfo(player: user, defaultValue: "You"),
          PlayerInfo(player: opponent, defaultValue: "Unknown opponent"),
          Expanded(
            child: ListView.builder(
              itemCount: game.questions.length,
              itemBuilder: (context, index) {
                return QuestionInfo(question: game.questions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}