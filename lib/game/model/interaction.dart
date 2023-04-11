import 'package:json_annotation/json_annotation.dart';

part 'interaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Interaction {
  final int? answerIdx;
  final bool answerTimerEnded;
  final bool resultTimerEnded;

  const Interaction({
    this.answerIdx,
    this.answerTimerEnded = false,
    this.resultTimerEnded = false,
  });

  Interaction copyWith({
    int? answerIdx,
    bool? answerTimerEnded,
    bool? resultTimerEnded,
  }) {
    return Interaction(
      answerIdx: answerIdx ?? this.answerIdx,
      answerTimerEnded: answerTimerEnded ?? this.answerTimerEnded,
      resultTimerEnded: resultTimerEnded ?? this.resultTimerEnded,
    );
  }

  factory Interaction.fromJson(Map<String, dynamic> json) => _$InteractionFromJson(json);

  Map<String, dynamic> toJson() => _$InteractionToJson(this);
}
