import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/auth/service/auth_cubit.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/common/widget/handling_stream_builder.dart';
import 'package:pv239_qwiz/common/widget/page_template.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/history/service/history_service.dart';
import 'package:pv239_qwiz/history/widget/games_list.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    final historyService = get<HistoryService>();
    final userId = context.read<AuthCubit>().userId;

    return PageTemplate(
      title: 'History',
      scrollable: false,
      child: HandlingStreamBuilder<List<Game>>(
        stream: historyService.getFinishedGamesOfUser(userId),
        builder: (context, games) {
          if (games.isEmpty) {
            return Center(
              child: Text(
                'You have not played any games yet.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }
          return GamesList(games: games);
        },
      ),
    );
  }
}
