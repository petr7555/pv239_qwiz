import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/player.dart';

class LeaderboardService {
  final _gamesCollection = FirebaseFirestore.instance.collection('games').withConverter(
        fromFirestore: (snapshot, _) => Game.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  Stream<List<Player>> get rankedPlayers => _gamesCollection
      .where('winnerId', isNull: false)
      .snapshots()
      .map((allGamesSnapshot) => rankPlayers(allGamesSnapshot.docs.map((game) => game.data()).toList()));

  static List<Player> rankPlayers(List<Game> games) {
    final allPlayers = games.expand((game) => game.players.values);

    final playersMap = allPlayers
        .fold<Map<String, Player>>(
          {},
          (players, player) {
            final existingPlayer = players[player.id];
            if (existingPlayer == null) {
              players[player.id] = player;
            } else {
              players[player.id] = existingPlayer.copyWith(points: existingPlayer.points + player.points);
            }
            return players;
          },
        )
        .values
        .toList();

    final sortedPlayers = playersMap..sort((a, b) => b.points.compareTo(a.points));

    return sortedPlayers;
  }
}
