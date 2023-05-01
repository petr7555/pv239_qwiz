import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pv239_qwiz/game/widget/menu_page.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
class Player with _$Player {
  const factory Player({
    required String id,
    String? displayName,
    String? photoURL,
    @Default(MenuPage.routeName) String route,
    @Default(0) int points,
    @Default(false) bool complete,
    @Default(false) bool answerTimerEnded,
    @Default(false) bool resultTimerEnded,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
