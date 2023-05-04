// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return _Player.fromJson(json);
}

/// @nodoc
mixin _$Player {
  String get id => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  String get route => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  bool get complete => throw _privateConstructorUsedError;
  bool get answerTimerEnded => throw _privateConstructorUsedError;
  bool get resultTimerEnded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call(
      {String id,
      String? displayName,
      String? photoURL,
      String route,
      int points,
      bool complete,
      bool answerTimerEnded,
      bool resultTimerEnded});
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? route = null,
    Object? points = null,
    Object? complete = null,
    Object? answerTimerEnded = null,
    Object? resultTimerEnded = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      complete: null == complete
          ? _value.complete
          : complete // ignore: cast_nullable_to_non_nullable
              as bool,
      answerTimerEnded: null == answerTimerEnded
          ? _value.answerTimerEnded
          : answerTimerEnded // ignore: cast_nullable_to_non_nullable
              as bool,
      resultTimerEnded: null == resultTimerEnded
          ? _value.resultTimerEnded
          : resultTimerEnded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$_PlayerCopyWith(_$_Player value, $Res Function(_$_Player) then) =
      __$$_PlayerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? displayName,
      String? photoURL,
      String route,
      int points,
      bool complete,
      bool answerTimerEnded,
      bool resultTimerEnded});
}

/// @nodoc
class __$$_PlayerCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$_Player>
    implements _$$_PlayerCopyWith<$Res> {
  __$$_PlayerCopyWithImpl(_$_Player _value, $Res Function(_$_Player) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = freezed,
    Object? photoURL = freezed,
    Object? route = null,
    Object? points = null,
    Object? complete = null,
    Object? answerTimerEnded = null,
    Object? resultTimerEnded = null,
  }) {
    return _then(_$_Player(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      complete: null == complete
          ? _value.complete
          : complete // ignore: cast_nullable_to_non_nullable
              as bool,
      answerTimerEnded: null == answerTimerEnded
          ? _value.answerTimerEnded
          : answerTimerEnded // ignore: cast_nullable_to_non_nullable
              as bool,
      resultTimerEnded: null == resultTimerEnded
          ? _value.resultTimerEnded
          : resultTimerEnded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Player implements _Player {
  const _$_Player(
      {required this.id,
      this.displayName,
      this.photoURL,
      this.route = MenuPage.routeName,
      this.points = 0,
      this.complete = false,
      this.answerTimerEnded = false,
      this.resultTimerEnded = false});

  factory _$_Player.fromJson(Map<String, dynamic> json) =>
      _$$_PlayerFromJson(json);

  @override
  final String id;
  @override
  final String? displayName;
  @override
  final String? photoURL;
  @override
  @JsonKey()
  final String route;
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey()
  final bool complete;
  @override
  @JsonKey()
  final bool answerTimerEnded;
  @override
  @JsonKey()
  final bool resultTimerEnded;

  @override
  String toString() {
    return 'Player(id: $id, displayName: $displayName, photoURL: $photoURL, route: $route, points: $points, complete: $complete, answerTimerEnded: $answerTimerEnded, resultTimerEnded: $resultTimerEnded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Player &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.complete, complete) ||
                other.complete == complete) &&
            (identical(other.answerTimerEnded, answerTimerEnded) ||
                other.answerTimerEnded == answerTimerEnded) &&
            (identical(other.resultTimerEnded, resultTimerEnded) ||
                other.resultTimerEnded == resultTimerEnded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, displayName, photoURL, route,
      points, complete, answerTimerEnded, resultTimerEnded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerCopyWith<_$_Player> get copyWith =>
      __$$_PlayerCopyWithImpl<_$_Player>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayerToJson(
      this,
    );
  }
}

abstract class _Player implements Player {
  const factory _Player(
      {required final String id,
      final String? displayName,
      final String? photoURL,
      final String route,
      final int points,
      final bool complete,
      final bool answerTimerEnded,
      final bool resultTimerEnded}) = _$_Player;

  factory _Player.fromJson(Map<String, dynamic> json) = _$_Player.fromJson;

  @override
  String get id;
  @override
  String? get displayName;
  @override
  String? get photoURL;
  @override
  String get route;
  @override
  int get points;
  @override
  bool get complete;
  @override
  bool get answerTimerEnded;
  @override
  bool get resultTimerEnded;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerCopyWith<_$_Player> get copyWith =>
      throw _privateConstructorUsedError;
}
