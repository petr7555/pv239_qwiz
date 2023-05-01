// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

/// @nodoc
mixin _$Question {
  String get id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  int get correctAnswerIdx => throw _privateConstructorUsedError;
  List<String> get allAnswers => throw _privateConstructorUsedError;
  Map<String, Interaction> get interactions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call(
      {String id,
      String question,
      int correctAnswerIdx,
      List<String> allAnswers,
      Map<String, Interaction> interactions});
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? correctAnswerIdx = null,
    Object? allAnswers = null,
    Object? interactions = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswerIdx: null == correctAnswerIdx
          ? _value.correctAnswerIdx
          : correctAnswerIdx // ignore: cast_nullable_to_non_nullable
              as int,
      allAnswers: null == allAnswers
          ? _value.allAnswers
          : allAnswers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      interactions: null == interactions
          ? _value.interactions
          : interactions // ignore: cast_nullable_to_non_nullable
              as Map<String, Interaction>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$$_QuestionCopyWith(
          _$_Question value, $Res Function(_$_Question) then) =
      __$$_QuestionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String question,
      int correctAnswerIdx,
      List<String> allAnswers,
      Map<String, Interaction> interactions});
}

/// @nodoc
class __$$_QuestionCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$_Question>
    implements _$$_QuestionCopyWith<$Res> {
  __$$_QuestionCopyWithImpl(
      _$_Question _value, $Res Function(_$_Question) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? correctAnswerIdx = null,
    Object? allAnswers = null,
    Object? interactions = null,
  }) {
    return _then(_$_Question(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswerIdx: null == correctAnswerIdx
          ? _value.correctAnswerIdx
          : correctAnswerIdx // ignore: cast_nullable_to_non_nullable
              as int,
      allAnswers: null == allAnswers
          ? _value._allAnswers
          : allAnswers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      interactions: null == interactions
          ? _value._interactions
          : interactions // ignore: cast_nullable_to_non_nullable
              as Map<String, Interaction>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Question implements _Question {
  const _$_Question(
      {required this.id,
      required this.question,
      required this.correctAnswerIdx,
      required final List<String> allAnswers,
      required final Map<String, Interaction> interactions})
      : _allAnswers = allAnswers,
        _interactions = interactions;

  factory _$_Question.fromJson(Map<String, dynamic> json) =>
      _$$_QuestionFromJson(json);

  @override
  final String id;
  @override
  final String question;
  @override
  final int correctAnswerIdx;
  final List<String> _allAnswers;
  @override
  List<String> get allAnswers {
    if (_allAnswers is EqualUnmodifiableListView) return _allAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allAnswers);
  }

  final Map<String, Interaction> _interactions;
  @override
  Map<String, Interaction> get interactions {
    if (_interactions is EqualUnmodifiableMapView) return _interactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_interactions);
  }

  @override
  String toString() {
    return 'Question(id: $id, question: $question, correctAnswerIdx: $correctAnswerIdx, allAnswers: $allAnswers, interactions: $interactions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Question &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAnswerIdx, correctAnswerIdx) ||
                other.correctAnswerIdx == correctAnswerIdx) &&
            const DeepCollectionEquality()
                .equals(other._allAnswers, _allAnswers) &&
            const DeepCollectionEquality()
                .equals(other._interactions, _interactions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      question,
      correctAnswerIdx,
      const DeepCollectionEquality().hash(_allAnswers),
      const DeepCollectionEquality().hash(_interactions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuestionCopyWith<_$_Question> get copyWith =>
      __$$_QuestionCopyWithImpl<_$_Question>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QuestionToJson(
      this,
    );
  }
}

abstract class _Question implements Question {
  const factory _Question(
      {required final String id,
      required final String question,
      required final int correctAnswerIdx,
      required final List<String> allAnswers,
      required final Map<String, Interaction> interactions}) = _$_Question;

  factory _Question.fromJson(Map<String, dynamic> json) = _$_Question.fromJson;

  @override
  String get id;
  @override
  String get question;
  @override
  int get correctAnswerIdx;
  @override
  List<String> get allAnswers;
  @override
  Map<String, Interaction> get interactions;
  @override
  @JsonKey(ignore: true)
  _$$_QuestionCopyWith<_$_Question> get copyWith =>
      throw _privateConstructorUsedError;
}
