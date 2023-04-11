import 'package:json_annotation/json_annotation.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';

part 'player.g.dart';

@JsonSerializable(explicitToJson: true)
class Player {
  final String id;
  final String route;
  final int points;
  final bool complete;
  final bool viewResults;
  final bool nextQuestion;

  const Player({
    required this.id,
    this.route = MenuPage.routeName,
    this.points = 0,
    this.complete = false,
    this.viewResults = false,
    this.nextQuestion = false,
  });

  Player copyWith({
    String? id,
    String? route,
    int? points,
    bool? complete,
    bool? viewResults,
    bool? nextQuestion,
  }) {
    return Player(
      id: id ?? this.id,
      route: route ?? this.route,
      points: points ?? this.points,
      complete: complete ?? this.complete,
      viewResults: viewResults ?? this.viewResults,
      nextQuestion: nextQuestion ?? this.nextQuestion,
    );
  }

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
