import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';
import 'package:pv239_qwiz/common/widget/handling_stream_builder.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/history/service/history_service.dart';
import 'package:pv239_qwiz/history/widget/game_info_header.dart';
import 'package:pv239_qwiz/history/widget/questions_list.dart';

class GameInfoPage extends StatelessWidget {
  final String gameId;

  const GameInfoPage({
    super.key,
    required this.gameId,
  });

  static const routeName = '/gameInfo';

  @override
  Widget build(BuildContext context) {
    final historyService = get<HistoryService>();

    return PageTemplate(
      title: 'Game info',
      scrollable: false,
      child: Center(
        child: HandlingStreamBuilder<Game>(
          stream: historyService.getGameById(gameId),
          builder: (context, game) {
            final userId = context.read<AuthCubit>().userId;
            final opponentId = game.opponent(userId).id;

            return Column(
              children: [
                GameInfoHeader(game: game),
                SizedBox(height: standardGap),
                Text('Questions', style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: smallGap),
                Expanded(
                  child: QuestionsList(
                    questions: game.questions,
                    opponentId: opponentId,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
