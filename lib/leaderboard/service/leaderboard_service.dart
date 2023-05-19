import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pv239_qwiz/game/model/game.dart';
import 'package:pv239_qwiz/game/model/player.dart';

class LeaderboardService {
  static Stream<List<Player>> getLeaderboardStream() {
    return FirebaseFirestore.instance
        .collection('games')
        .snapshots()
        .map((snapshot) => _calculatePlayerRankList(snapshot.docs.map((doc) => Game.fromJson(doc.data())).toList()));
  }

  static List<Player> _calculatePlayerRankList(List<Game> games) {
    final players = games
        .map((game) => game.players.values) // Get list of player maps
        .expand((playerMap) => playerMap) // Flatten the list of player maps
        .where((player) => player.complete) // Filter completed players
        .toList();

    // Accumulate points per player using fold()
    final playerTotalScores = players.fold<Map<String, Player>>(
      {},
          (Map<String, Player> accumulator, Player player) {
        final existingPlayer = accumulator[player.id];
        if (existingPlayer == null) {
          accumulator[player.id] = player;
        } else {
          accumulator[player.id] =
              existingPlayer.copyWith(points: existingPlayer.points + player.points);
        }
        return accumulator;
      },
    );

    final playerRankList =
    playerTotalScores.values.toList()..sort((a, b) => b.points.compareTo(a.points));

    return playerRankList;
  }
}
