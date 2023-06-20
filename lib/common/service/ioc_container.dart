import 'package:get_it/get_it.dart';
import 'package:pv239_qwiz/common/util/shared_logic_constants.dart';
import 'package:pv239_qwiz/game/service/game_service.dart';
import 'package:pv239_qwiz/game/service/question_api_service.dart';
import 'package:pv239_qwiz/history/service/history_service.dart';
import 'package:pv239_qwiz/leaderboard/service/leaderboard_service.dart';
import 'package:random_string_generator/random_string_generator.dart';

final get = GetIt.instance;

class IoCContainer {
  IoCContainer._();

  static void initialize() {
    get.registerSingleton(RandomStringGenerator(
      fixedLength: gameCodeLength,
      alphaCase: AlphaCase.LOWERCASE_ONLY,
      hasSymbols: false,
      // remove 'o' and '0' to avoid confusion
      customLowerAlphabet: 'abcdefghijklmnpqrstuvwxyz'.split(''),
      customDigits: '123456789'.split(''),
    ));
    get.registerSingleton(GameService());
    get.registerSingleton(QuestionApiService());
    get.registerSingleton(HistoryService());
    get.registerSingleton(LeaderboardService());
  }
}
