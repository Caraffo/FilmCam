// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhotoRecord {

/// Clave de la foto revelada (su nombre en la galería).
 String get key;/// Clave del original guardado en privado. Varias ediciones pueden
/// compartir el mismo original.
 String get originalKey; FilmPreset get look; DateTime? get dateStamp; bool get originalExported;
/// Create a copy of PhotoRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoRecordCopyWith<PhotoRecord> get copyWith => _$PhotoRecordCopyWithImpl<PhotoRecord>(this as PhotoRecord, _$identity);

  /// Serializes this PhotoRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhotoRecord&&(identical(other.key, key) || other.key == key)&&(identical(other.originalKey, originalKey) || other.originalKey == originalKey)&&(identical(other.look, look) || other.look == look)&&(identical(other.dateStamp, dateStamp) || other.dateStamp == dateStamp)&&(identical(other.originalExported, originalExported) || other.originalExported == originalExported));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,originalKey,look,dateStamp,originalExported);

@override
String toString() {
  return 'PhotoRecord(key: $key, originalKey: $originalKey, look: $look, dateStamp: $dateStamp, originalExported: $originalExported)';
}


}

/// @nodoc
abstract mixin class $PhotoRecordCopyWith<$Res>  {
  factory $PhotoRecordCopyWith(PhotoRecord value, $Res Function(PhotoRecord) _then) = _$PhotoRecordCopyWithImpl;
@useResult
$Res call({
 String key, String originalKey, FilmPreset look, DateTime? dateStamp, bool originalExported
});


$FilmPresetCopyWith<$Res> get look;

}
/// @nodoc
class _$PhotoRecordCopyWithImpl<$Res>
    implements $PhotoRecordCopyWith<$Res> {
  _$PhotoRecordCopyWithImpl(this._self, this._then);

  final PhotoRecord _self;
  final $Res Function(PhotoRecord) _then;

/// Create a copy of PhotoRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? originalKey = null,Object? look = null,Object? dateStamp = freezed,Object? originalExported = null,}) {
  return _then(PhotoRecord(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,originalKey: null == originalKey ? _self.originalKey : originalKey // ignore: cast_nullable_to_non_nullable
as String,look: null == look ? _self.look : look // ignore: cast_nullable_to_non_nullable
as FilmPreset,dateStamp: freezed == dateStamp ? _self.dateStamp : dateStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,originalExported: null == originalExported ? _self.originalExported : originalExported // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PhotoRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FilmPresetCopyWith<$Res> get look {
  
  return $FilmPresetCopyWith<$Res>(_self.look, (value) {
    return _then(_self.copyWith(look: value));
  });
}
}


/// Adds pattern-matching-related methods to [PhotoRecord].
extension PhotoRecordPatterns on PhotoRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhotoRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhotoRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhotoRecord value)  $default,){
final _that = this;
switch (_that) {
case _PhotoRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhotoRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PhotoRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String originalKey,  FilmPreset look,  DateTime? dateStamp,  bool originalExported)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhotoRecord() when $default != null:
return $default(_that.key,_that.originalKey,_that.look,_that.dateStamp,_that.originalExported);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String originalKey,  FilmPreset look,  DateTime? dateStamp,  bool originalExported)  $default,) {final _that = this;
switch (_that) {
case _PhotoRecord():
return $default(_that.key,_that.originalKey,_that.look,_that.dateStamp,_that.originalExported);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String originalKey,  FilmPreset look,  DateTime? dateStamp,  bool originalExported)?  $default,) {final _that = this;
switch (_that) {
case _PhotoRecord() when $default != null:
return $default(_that.key,_that.originalKey,_that.look,_that.dateStamp,_that.originalExported);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _PhotoRecord implements PhotoRecord {
  const _PhotoRecord({required this.key, required this.originalKey, required this.look, this.dateStamp, this.originalExported = false});
  factory _PhotoRecord.fromJson(Map<String, dynamic> json) => _$PhotoRecordFromJson(json);

/// Clave de la foto revelada (su nombre en la galería).
@override final  String key;
/// Clave del original guardado en privado. Varias ediciones pueden
/// compartir el mismo original.
@override final  String originalKey;
@override final  FilmPreset look;
@override final  DateTime? dateStamp;
@override@JsonKey() final  bool originalExported;

/// Create a copy of PhotoRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoRecordCopyWith<_PhotoRecord> get copyWith => __$PhotoRecordCopyWithImpl<_PhotoRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhotoRecord&&(identical(other.key, key) || other.key == key)&&(identical(other.originalKey, originalKey) || other.originalKey == originalKey)&&(identical(other.look, look) || other.look == look)&&(identical(other.dateStamp, dateStamp) || other.dateStamp == dateStamp)&&(identical(other.originalExported, originalExported) || other.originalExported == originalExported));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,originalKey,look,dateStamp,originalExported);

@override
String toString() {
  return 'PhotoRecord(key: $key, originalKey: $originalKey, look: $look, dateStamp: $dateStamp, originalExported: $originalExported)';
}


}

/// @nodoc
abstract mixin class _$PhotoRecordCopyWith<$Res> implements $PhotoRecordCopyWith<$Res> {
  factory _$PhotoRecordCopyWith(_PhotoRecord value, $Res Function(_PhotoRecord) _then) = __$PhotoRecordCopyWithImpl;
@override @useResult
$Res call({
 String key, String originalKey, FilmPreset look, DateTime? dateStamp, bool originalExported
});


@override $FilmPresetCopyWith<$Res> get look;

}
/// @nodoc
class __$PhotoRecordCopyWithImpl<$Res>
    implements _$PhotoRecordCopyWith<$Res> {
  __$PhotoRecordCopyWithImpl(this._self, this._then);

  final _PhotoRecord _self;
  final $Res Function(_PhotoRecord) _then;

/// Create a copy of PhotoRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? originalKey = null,Object? look = null,Object? dateStamp = freezed,Object? originalExported = null,}) {
  return _then(_PhotoRecord(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,originalKey: null == originalKey ? _self.originalKey : originalKey // ignore: cast_nullable_to_non_nullable
as String,look: null == look ? _self.look : look // ignore: cast_nullable_to_non_nullable
as FilmPreset,dateStamp: freezed == dateStamp ? _self.dateStamp : dateStamp // ignore: cast_nullable_to_non_nullable
as DateTime?,originalExported: null == originalExported ? _self.originalExported : originalExported // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PhotoRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FilmPresetCopyWith<$Res> get look {
  
  return $FilmPresetCopyWith<$Res>(_self.look, (value) {
    return _then(_self.copyWith(look: value));
  });
}
}

// dart format on
