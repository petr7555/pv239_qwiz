import 'package:freezed_annotation/freezed_annotation.dart';

part 'interaction.freezed.dart';
part 'interaction.g.dart';

@freezed
class Interaction with _$Interaction {
  const factory Interaction({
    int? answerIdx,
    double? secondsToAnswer,
    @Default(0) int deltaPoints,
  }) = _Interaction;

  factory Interaction.fromJson(Map<String, dynamic> json) => _$InteractionFromJson(json);
}
