import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pv239_qwiz/game/model/game.dart';

class GameService {
  final gamesCollection = FirebaseFirestore.instance.collection('games').withConverter(
        fromFirestore: (snapshot, _) => Game.fromJson(snapshot.data()!..['id'] = snapshot.id),
        toFirestore: (model, _) => model.toJson()..remove('id'),
      );

  // Stream<List<Note>> get notesStream => gamesCollection
  //     .snapshots()
  //     .map((querySnapshot) => querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> createGame(Game game) {
    return gamesCollection.doc(game.id).set(game);
  }

  Future<Game?> getGame(String id) {
    return gamesCollection.doc(id).get().then((value) => value.data());
  }

  // Future<void> deleteGameById(String id) {
  //   return gamesCollection.doc(id).delete();
  // }
}
