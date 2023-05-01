// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Interaction _$InteractionFromJson(Map<String, dynamic> json) {
  return _Interaction.fromJson(json);
}

/// @nodoc
mixin _$Interaction {
  int? get answerIdx => throw _privateConstructorUsedError;
  double? get secondsToAnswer => throw _privateConstructorUsedError;
  int get deltaPoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InteractionCopyWith<Interaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InteractionCopyWith<$Res> {
  factory $InteractionCopyWith(
          Interaction value, $Res Function(Interaction) then) =
      _$InteractionCopyWithImpl<$Res, Interaction>;
  @useResult
  $Res call({int? answerIdx, double? secondsToAnswer, int deltaPoints});
}

/// @nodoc
class _$InteractionCopyWithImpl<$Res, $Val extends Interaction>
    implements $InteractionCopyWith<$Res> {
  _$InteractionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answerIdx = freezed,
    Object? secondsToAnswer = freezed,
    Object? deltaPoints = null,
  }) {
    return _then(_value.copyWith(
      answerIdx: freezed == answerIdx
          ? _value.answerIdx
          : answerIdx // ignore: cast_nullable_to_non_nullable
              as int?,
      secondsToAnswer: freezed == secondsToAnswer
          ? _value.secondsToAnswer
          : secondsToAnswer // ignore: cast_nullable_to_non_nullable
              as double?,
      deltaPoints: null == deltaPoints
          ? _value.deltaPoints
          : deltaPoints // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InteractionCopyWith<$Res>
    implements $InteractionCopyWith<$Res> {
  factory _$$_InteractionCopyWith(
          _$_Interaction value, $Res Function(_$_Interaction) then) =
      __$$_InteractionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? answerIdx, double? secondsToAnswer, int deltaPoints});
}

/// @nodoc
class __$$_InteractionCopyWithImpl<$Res>
    extends _$InteractionCopyWithImpl<$Res, _$_Interaction>
    implements _$$_InteractionCopyWith<$Res> {
  __$$_InteractionCopyWithImpl(
      _$_Interaction _value, $Res Function(_$_Interaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answerIdx = freezed,
    Object? secondsToAnswer = freezed,
    Object? deltaPoints = null,
  }) {
    return _then(_$_Interaction(
      answerIdx: freezed == answerIdx
          ? _value.answerIdx
          : answerIdx // ignore: cast_nullable_to_non_nullable
              as int?,
      secondsToAnswer: freezed == secondsToAnswer
          ? _value.secondsToAnswer
          : secondsToAnswer // ignore: cast_nullable_to_non_nullable
              as double?,
      deltaPoints: null == deltaPoints
          ? _value.deltaPoints
          : deltaPoints // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Interaction implements _Interaction {
  const _$_Interaction(
      {this.answerIdx, this.secondsToAnswer, this.deltaPoints = 0});

  factory _$_Interaction.fromJson(Map<String, dynamic> json) =>
      _$$_InteractionFromJson(json);

  @override
  final int? answerIdx;
  @override
  final double? secondsToAnswer;
  @override
  @JsonKey()
  final int deltaPoints;

  @override
  String toString() {
    return 'Interaction(answerIdx: $answerIdx, secondsToAnswer: $secondsToAnswer, deltaPoints: $deltaPoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Interaction &&
            (identical(other.answerIdx, answerIdx) ||
                other.answerIdx == answerIdx) &&
            (identical(other.secondsToAnswer, secondsToAnswer) ||
                other.secondsToAnswer == secondsToAnswer) &&
            (identical(other.deltaPoints, deltaPoints) ||
                other.deltaPoints == deltaPoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, answerIdx, secondsToAnswer, deltaPoints);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InteractionCopyWith<_$_Interaction> get copyWith =>
      __$$_InteractionCopyWithImpl<_$_Interaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InteractionToJson(
      this,
    );
  }
}

abstract class _Interaction implements Interaction {
  const factory _Interaction(
      {final int? answerIdx,
      final double? secondsToAnswer,
      final int deltaPoints}) = _$_Interaction;

  factory _Interaction.fromJson(Map<String, dynamic> json) =
      _$_Interaction.fromJson;

  @override
  int? get answerIdx;
  @override
  double? get secondsToAnswer;
  @override
  int get deltaPoints;
  @override
  @JsonKey(ignore: true)
  _$$_InteractionCopyWith<_$_Interaction> get copyWith =>
      throw _privateConstructorUsedError;
}
