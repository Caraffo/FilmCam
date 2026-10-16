// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GalleryPhoto {

 AssetEntity get asset; String? get key;
/// Create a copy of GalleryPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GalleryPhotoCopyWith<GalleryPhoto> get copyWith => _$GalleryPhotoCopyWithImpl<GalleryPhoto>(this as GalleryPhoto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GalleryPhoto&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.key, key) || other.key == key));
}


@override
int get hashCode => Object.hash(runtimeType,asset,key);

@override
String toString() {
  return 'GalleryPhoto(asset: $asset, key: $key)';
}


}

/// @nodoc
abstract mixin class $GalleryPhotoCopyWith<$Res>  {
  factory $GalleryPhotoCopyWith(GalleryPhoto value, $Res Function(GalleryPhoto) _then) = _$GalleryPhotoCopyWithImpl;
@useResult
$Res call({
 AssetEntity asset, String? key
});




}
/// @nodoc
class _$GalleryPhotoCopyWithImpl<$Res>
    implements $GalleryPhotoCopyWith<$Res> {
  _$GalleryPhotoCopyWithImpl(this._self, this._then);

  final GalleryPhoto _self;
  final $Res Function(GalleryPhoto) _then;

/// Create a copy of GalleryPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? asset = null,Object? key = freezed,}) {
  return _then(GalleryPhoto(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as AssetEntity,key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GalleryPhoto].
extension GalleryPhotoPatterns on GalleryPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GalleryPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GalleryPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GalleryPhoto value)  $default,){
final _that = this;
switch (_that) {
case _GalleryPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GalleryPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _GalleryPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AssetEntity asset,  String? key)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GalleryPhoto() when $default != null:
return $default(_that.asset,_that.key);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AssetEntity asset,  String? key)  $default,) {final _that = this;
switch (_that) {
case _GalleryPhoto():
return $default(_that.asset,_that.key);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AssetEntity asset,  String? key)?  $default,) {final _that = this;
switch (_that) {
case _GalleryPhoto() when $default != null:
return $default(_that.asset,_that.key);case _:
  return null;

}
}

}

/// @nodoc


class _GalleryPhoto implements GalleryPhoto {
  const _GalleryPhoto({required this.asset, this.key});
  

@override final  AssetEntity asset;
@override final  String? key;

/// Create a copy of GalleryPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GalleryPhotoCopyWith<_GalleryPhoto> get copyWith => __$GalleryPhotoCopyWithImpl<_GalleryPhoto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GalleryPhoto&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.key, key) || other.key == key));
}


@override
int get hashCode => Object.hash(runtimeType,asset,key);

@override
String toString() {
  return 'GalleryPhoto(asset: $asset, key: $key)';
}


}

/// @nodoc
abstract mixin class _$GalleryPhotoCopyWith<$Res> implements $GalleryPhotoCopyWith<$Res> {
  factory _$GalleryPhotoCopyWith(_GalleryPhoto value, $Res Function(_GalleryPhoto) _then) = __$GalleryPhotoCopyWithImpl;
@override @useResult
$Res call({
 AssetEntity asset, String? key
});




}
/// @nodoc
class __$GalleryPhotoCopyWithImpl<$Res>
    implements _$GalleryPhotoCopyWith<$Res> {
  __$GalleryPhotoCopyWithImpl(this._self, this._then);

  final _GalleryPhoto _self;
  final $Res Function(_GalleryPhoto) _then;

/// Create a copy of GalleryPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? asset = null,Object? key = freezed,}) {
  return _then(_GalleryPhoto(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as AssetEntity,key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
