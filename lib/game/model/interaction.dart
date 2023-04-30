import 'package:json_annotation/json_annotation.dart';

part 'interaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Interaction {
  final int? answerIdx;
  final double? secondsToAnswer;

  const Interaction({
    this.answerIdx,
    this.secondsToAnswer,
  });

  Interaction copyWith({
    int? answerIdx,
    double? secondsToAnswer,
  }) {
    return Interaction(
      answerIdx: answerIdx ?? this.answerIdx,
      secondsToAnswer: secondsToAnswer ?? this.secondsToAnswer,
    );
  }

  factory Interaction.fromJson(Map<String, dynamic> json) => _$InteractionFromJson(json);

  Map<String, dynamic> toJson() => _$InteractionToJson(this);
}
