import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';

part 'player.g.dart';

@JsonSerializable(explicitToJson: true)
class Player {
  final String id;
  final String? displayName;
  final String? photoURL;
  final String route;
  final int points;
  final bool complete;
  final bool answerTimerEnded;
  final bool resultTimerEnded;

  const Player({
    required this.id,
    this.displayName,
    this.photoURL,
    this.route = MenuPage.routeName,
    this.points = 0,
    this.complete = false,
    this.answerTimerEnded = false,
    this.resultTimerEnded = false,
  });

  Player copyWith({
    String? id,
    String? displayName,
    String? photoURL,
    String? route,
    int? points,
    bool? complete,
    bool? answerTimerEnded,
    bool? resultTimerEnded,
  }) {
    return Player(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      route: route ?? this.route,
      points: points ?? this.points,
      complete: complete ?? this.complete,
      answerTimerEnded: answerTimerEnded ?? this.answerTimerEnded,
      resultTimerEnded: resultTimerEnded ?? this.resultTimerEnded,
    );
  }

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
