// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'captured_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CapturedPhoto {

 Uint8List get original; Uint8List? get filtered; bool get originalSaved; Object? get processingError;
/// Create a copy of CapturedPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapturedPhotoCopyWith<CapturedPhoto> get copyWith => _$CapturedPhotoCopyWithImpl<CapturedPhoto>(this as CapturedPhoto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CapturedPhoto&&const DeepCollectionEquality().equals(other.original, original)&&const DeepCollectionEquality().equals(other.filtered, filtered)&&(identical(other.originalSaved, originalSaved) || other.originalSaved == originalSaved)&&const DeepCollectionEquality().equals(other.processingError, processingError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(original),const DeepCollectionEquality().hash(filtered),originalSaved,const DeepCollectionEquality().hash(processingError));

@override
String toString() {
  return 'CapturedPhoto(original: $original, filtered: $filtered, originalSaved: $originalSaved, processingError: $processingError)';
}


}

/// @nodoc
abstract mixin class $CapturedPhotoCopyWith<$Res>  {
  factory $CapturedPhotoCopyWith(CapturedPhoto value, $Res Function(CapturedPhoto) _then) = _$CapturedPhotoCopyWithImpl;
@useResult
$Res call({
 Uint8List original, Uint8List? filtered, bool originalSaved, Object? processingError
});




}
/// @nodoc
class _$CapturedPhotoCopyWithImpl<$Res>
    implements $CapturedPhotoCopyWith<$Res> {
  _$CapturedPhotoCopyWithImpl(this._self, this._then);

  final CapturedPhoto _self;
  final $Res Function(CapturedPhoto) _then;

/// Create a copy of CapturedPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? original = null,Object? filtered = freezed,Object? originalSaved = null,Object? processingError = freezed,}) {
  return _then(CapturedPhoto(
original: null == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Uint8List,filtered: freezed == filtered ? _self.filtered : filtered // ignore: cast_nullable_to_non_nullable
as Uint8List?,originalSaved: null == originalSaved ? _self.originalSaved : originalSaved // ignore: cast_nullable_to_non_nullable
as bool,processingError: freezed == processingError ? _self.processingError : processingError ,
  ));
}

}


/// Adds pattern-matching-related methods to [CapturedPhoto].
extension CapturedPhotoPatterns on CapturedPhoto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CapturedPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CapturedPhoto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CapturedPhoto value)  $default,){
final _that = this;
switch (_that) {
case _CapturedPhoto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CapturedPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _CapturedPhoto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uint8List original,  Uint8List? filtered,  bool originalSaved,  Object? processingError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CapturedPhoto() when $default != null:
return $default(_that.original,_that.filtered,_that.originalSaved,_that.processingError);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uint8List original,  Uint8List? filtered,  bool originalSaved,  Object? processingError)  $default,) {final _that = this;
switch (_that) {
case _CapturedPhoto():
return $default(_that.original,_that.filtered,_that.originalSaved,_that.processingError);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uint8List original,  Uint8List? filtered,  bool originalSaved,  Object? processingError)?  $default,) {final _that = this;
switch (_that) {
case _CapturedPhoto() when $default != null:
return $default(_that.original,_that.filtered,_that.originalSaved,_that.processingError);case _:
  return null;

}
}

}

/// @nodoc


class _CapturedPhoto extends CapturedPhoto {
  const _CapturedPhoto({required this.original, this.filtered, this.originalSaved = false, this.processingError}): super._();
  

@override final  Uint8List original;
@override final  Uint8List? filtered;
@override@JsonKey() final  bool originalSaved;
@override final  Object? processingError;

/// Create a copy of CapturedPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapturedPhotoCopyWith<_CapturedPhoto> get copyWith => __$CapturedPhotoCopyWithImpl<_CapturedPhoto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CapturedPhoto&&const DeepCollectionEquality().equals(other.original, original)&&const DeepCollectionEquality().equals(other.filtered, filtered)&&(identical(other.originalSaved, originalSaved) || other.originalSaved == originalSaved)&&const DeepCollectionEquality().equals(other.processingError, processingError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(original),const DeepCollectionEquality().hash(filtered),originalSaved,const DeepCollectionEquality().hash(processingError));

@override
String toString() {
  return 'CapturedPhoto(original: $original, filtered: $filtered, originalSaved: $originalSaved, processingError: $processingError)';
}


}

/// @nodoc
abstract mixin class _$CapturedPhotoCopyWith<$Res> implements $CapturedPhotoCopyWith<$Res> {
  factory _$CapturedPhotoCopyWith(_CapturedPhoto value, $Res Function(_CapturedPhoto) _then) = __$CapturedPhotoCopyWithImpl;
@override @useResult
$Res call({
 Uint8List original, Uint8List? filtered, bool originalSaved, Object? processingError
});




}
/// @nodoc
class __$CapturedPhotoCopyWithImpl<$Res>
    implements _$CapturedPhotoCopyWith<$Res> {
  __$CapturedPhotoCopyWithImpl(this._self, this._then);

  final _CapturedPhoto _self;
  final $Res Function(_CapturedPhoto) _then;

/// Create a copy of CapturedPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? original = null,Object? filtered = freezed,Object? originalSaved = null,Object? processingError = freezed,}) {
  return _then(_CapturedPhoto(
original: null == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Uint8List,filtered: freezed == filtered ? _self.filtered : filtered // ignore: cast_nullable_to_non_nullable
as Uint8List?,originalSaved: null == originalSaved ? _self.originalSaved : originalSaved // ignore: cast_nullable_to_non_nullable
as bool,processingError: freezed == processingError ? _self.processingError : processingError ,
  ));
}


}

// dart format on
