import 'package:json_annotation/json_annotation.dart';

part 'interaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Interaction {
  final int? answerIdx;
  final double? secondsToAnswer;
  final int deltaPoints;

  const Interaction({
    this.answerIdx,
    this.secondsToAnswer,
    this.deltaPoints = 0,
  });

  Interaction copyWith({
    int? answerIdx,
    double? secondsToAnswer,
    int? deltaPoints,
  }) {
    return Interaction(
      answerIdx: answerIdx ?? this.answerIdx,
      secondsToAnswer: secondsToAnswer ?? this.secondsToAnswer,
      deltaPoints: deltaPoints ?? this.deltaPoints,
    );
  }

  factory Interaction.fromJson(Map<String, dynamic> json) => _$InteractionFromJson(json);

  Map<String, dynamic> toJson() => _$InteractionToJson(this);
}
