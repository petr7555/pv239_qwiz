import 'package:json_annotation/json_annotation.dart';

part 'interaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Interaction {
  final int? answerIdx;

  const Interaction({
    this.answerIdx,
  });

  Interaction copyWith({
    int? answerIdx,
  }) {
    return Interaction(
      answerIdx: answerIdx ?? this.answerIdx,
    );
  }

  factory Interaction.fromJson(Map<String, dynamic> json) => _$InteractionFromJson(json);

  Map<String, dynamic> toJson() => _$InteractionToJson(this);
}
