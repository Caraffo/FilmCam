// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'film_preset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FilmPreset {

 String get id; String get name; bool get isBuiltIn; double get exposure; double get temperatureK; double get tint; double get contrast; double get saturation; double get fade; int get shadowTintColor; double get shadowTintStrength; int get highlightTintColor; double get highlightTintStrength; String? get lutAsset; double get lutIntensity; double get grain; double get grainSize; double get vignette; double get halation;
/// Create a copy of FilmPreset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilmPresetCopyWith<FilmPreset> get copyWith => _$FilmPresetCopyWithImpl<FilmPreset>(this as FilmPreset, _$identity);

  /// Serializes this FilmPreset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilmPreset&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isBuiltIn, isBuiltIn) || other.isBuiltIn == isBuiltIn)&&(identical(other.exposure, exposure) || other.exposure == exposure)&&(identical(other.temperatureK, temperatureK) || other.temperatureK == temperatureK)&&(identical(other.tint, tint) || other.tint == tint)&&(identical(other.contrast, contrast) || other.contrast == contrast)&&(identical(other.saturation, saturation) || other.saturation == saturation)&&(identical(other.fade, fade) || other.fade == fade)&&(identical(other.shadowTintColor, shadowTintColor) || other.shadowTintColor == shadowTintColor)&&(identical(other.shadowTintStrength, shadowTintStrength) || other.shadowTintStrength == shadowTintStrength)&&(identical(other.highlightTintColor, highlightTintColor) || other.highlightTintColor == highlightTintColor)&&(identical(other.highlightTintStrength, highlightTintStrength) || other.highlightTintStrength == highlightTintStrength)&&(identical(other.lutAsset, lutAsset) || other.lutAsset == lutAsset)&&(identical(other.lutIntensity, lutIntensity) || other.lutIntensity == lutIntensity)&&(identical(other.grain, grain) || other.grain == grain)&&(identical(other.grainSize, grainSize) || other.grainSize == grainSize)&&(identical(other.vignette, vignette) || other.vignette == vignette)&&(identical(other.halation, halation) || other.halation == halation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,isBuiltIn,exposure,temperatureK,tint,contrast,saturation,fade,shadowTintColor,shadowTintStrength,highlightTintColor,highlightTintStrength,lutAsset,lutIntensity,grain,grainSize,vignette,halation]);

@override
String toString() {
  return 'FilmPreset(id: $id, name: $name, isBuiltIn: $isBuiltIn, exposure: $exposure, temperatureK: $temperatureK, tint: $tint, contrast: $contrast, saturation: $saturation, fade: $fade, shadowTintColor: $shadowTintColor, shadowTintStrength: $shadowTintStrength, highlightTintColor: $highlightTintColor, highlightTintStrength: $highlightTintStrength, lutAsset: $lutAsset, lutIntensity: $lutIntensity, grain: $grain, grainSize: $grainSize, vignette: $vignette, halation: $halation)';
}


}

/// @nodoc
abstract mixin class $FilmPresetCopyWith<$Res>  {
  factory $FilmPresetCopyWith(FilmPreset value, $Res Function(FilmPreset) _then) = _$FilmPresetCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool isBuiltIn, double exposure, double temperatureK, double tint, double contrast, double saturation, double fade, int shadowTintColor, double shadowTintStrength, int highlightTintColor, double highlightTintStrength, String? lutAsset, double lutIntensity, double grain, double grainSize, double vignette, double halation
});




}
/// @nodoc
class _$FilmPresetCopyWithImpl<$Res>
    implements $FilmPresetCopyWith<$Res> {
  _$FilmPresetCopyWithImpl(this._self, this._then);

  final FilmPreset _self;
  final $Res Function(FilmPreset) _then;

/// Create a copy of FilmPreset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isBuiltIn = null,Object? exposure = null,Object? temperatureK = null,Object? tint = null,Object? contrast = null,Object? saturation = null,Object? fade = null,Object? shadowTintColor = null,Object? shadowTintStrength = null,Object? highlightTintColor = null,Object? highlightTintStrength = null,Object? lutAsset = freezed,Object? lutIntensity = null,Object? grain = null,Object? grainSize = null,Object? vignette = null,Object? halation = null,}) {
  return _then(FilmPreset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isBuiltIn: null == isBuiltIn ? _self.isBuiltIn : isBuiltIn // ignore: cast_nullable_to_non_nullable
as bool,exposure: null == exposure ? _self.exposure : exposure // ignore: cast_nullable_to_non_nullable
as double,temperatureK: null == temperatureK ? _self.temperatureK : temperatureK // ignore: cast_nullable_to_non_nullable
as double,tint: null == tint ? _self.tint : tint // ignore: cast_nullable_to_non_nullable
as double,contrast: null == contrast ? _self.contrast : contrast // ignore: cast_nullable_to_non_nullable
as double,saturation: null == saturation ? _self.saturation : saturation // ignore: cast_nullable_to_non_nullable
as double,fade: null == fade ? _self.fade : fade // ignore: cast_nullable_to_non_nullable
as double,shadowTintColor: null == shadowTintColor ? _self.shadowTintColor : shadowTintColor // ignore: cast_nullable_to_non_nullable
as int,shadowTintStrength: null == shadowTintStrength ? _self.shadowTintStrength : shadowTintStrength // ignore: cast_nullable_to_non_nullable
as double,highlightTintColor: null == highlightTintColor ? _self.highlightTintColor : highlightTintColor // ignore: cast_nullable_to_non_nullable
as int,highlightTintStrength: null == highlightTintStrength ? _self.highlightTintStrength : highlightTintStrength // ignore: cast_nullable_to_non_nullable
as double,lutAsset: freezed == lutAsset ? _self.lutAsset : lutAsset // ignore: cast_nullable_to_non_nullable
as String?,lutIntensity: null == lutIntensity ? _self.lutIntensity : lutIntensity // ignore: cast_nullable_to_non_nullable
as double,grain: null == grain ? _self.grain : grain // ignore: cast_nullable_to_non_nullable
as double,grainSize: null == grainSize ? _self.grainSize : grainSize // ignore: cast_nullable_to_non_nullable
as double,vignette: null == vignette ? _self.vignette : vignette // ignore: cast_nullable_to_non_nullable
as double,halation: null == halation ? _self.halation : halation // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FilmPreset].
extension FilmPresetPatterns on FilmPreset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilmPreset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilmPreset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilmPreset value)  $default,){
final _that = this;
switch (_that) {
case _FilmPreset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilmPreset value)?  $default,){
final _that = this;
switch (_that) {
case _FilmPreset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool isBuiltIn,  double exposure,  double temperatureK,  double tint,  double contrast,  double saturation,  double fade,  int shadowTintColor,  double shadowTintStrength,  int highlightTintColor,  double highlightTintStrength,  String? lutAsset,  double lutIntensity,  double grain,  double grainSize,  double vignette,  double halation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilmPreset() when $default != null:
return $default(_that.id,_that.name,_that.isBuiltIn,_that.exposure,_that.temperatureK,_that.tint,_that.contrast,_that.saturation,_that.fade,_that.shadowTintColor,_that.shadowTintStrength,_that.highlightTintColor,_that.highlightTintStrength,_that.lutAsset,_that.lutIntensity,_that.grain,_that.grainSize,_that.vignette,_that.halation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool isBuiltIn,  double exposure,  double temperatureK,  double tint,  double contrast,  double saturation,  double fade,  int shadowTintColor,  double shadowTintStrength,  int highlightTintColor,  double highlightTintStrength,  String? lutAsset,  double lutIntensity,  double grain,  double grainSize,  double vignette,  double halation)  $default,) {final _that = this;
switch (_that) {
case _FilmPreset():
return $default(_that.id,_that.name,_that.isBuiltIn,_that.exposure,_that.temperatureK,_that.tint,_that.contrast,_that.saturation,_that.fade,_that.shadowTintColor,_that.shadowTintStrength,_that.highlightTintColor,_that.highlightTintStrength,_that.lutAsset,_that.lutIntensity,_that.grain,_that.grainSize,_that.vignette,_that.halation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool isBuiltIn,  double exposure,  double temperatureK,  double tint,  double contrast,  double saturation,  double fade,  int shadowTintColor,  double shadowTintStrength,  int highlightTintColor,  double highlightTintStrength,  String? lutAsset,  double lutIntensity,  double grain,  double grainSize,  double vignette,  double halation)?  $default,) {final _that = this;
switch (_that) {
case _FilmPreset() when $default != null:
return $default(_that.id,_that.name,_that.isBuiltIn,_that.exposure,_that.temperatureK,_that.tint,_that.contrast,_that.saturation,_that.fade,_that.shadowTintColor,_that.shadowTintStrength,_that.highlightTintColor,_that.highlightTintStrength,_that.lutAsset,_that.lutIntensity,_that.grain,_that.grainSize,_that.vignette,_that.halation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FilmPreset implements FilmPreset {
  const _FilmPreset({required this.id, required this.name, this.isBuiltIn = false, this.exposure = 0, this.temperatureK = kNeutralTemperatureK, this.tint = 0, this.contrast = 0, this.saturation = 0, this.fade = 0, this.shadowTintColor = kNeutralTintColor, this.shadowTintStrength = 0, this.highlightTintColor = kNeutralTintColor, this.highlightTintStrength = 0, this.lutAsset, this.lutIntensity = 1, this.grain = 0, this.grainSize = 1.5, this.vignette = 0, this.halation = 0});
  factory _FilmPreset.fromJson(Map<String, dynamic> json) => _$FilmPresetFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  bool isBuiltIn;
@override@JsonKey() final  double exposure;
@override@JsonKey() final  double temperatureK;
@override@JsonKey() final  double tint;
@override@JsonKey() final  double contrast;
@override@JsonKey() final  double saturation;
@override@JsonKey() final  double fade;
@override@JsonKey() final  int shadowTintColor;
@override@JsonKey() final  double shadowTintStrength;
@override@JsonKey() final  int highlightTintColor;
@override@JsonKey() final  double highlightTintStrength;
@override final  String? lutAsset;
@override@JsonKey() final  double lutIntensity;
@override@JsonKey() final  double grain;
@override@JsonKey() final  double grainSize;
@override@JsonKey() final  double vignette;
@override@JsonKey() final  double halation;

/// Create a copy of FilmPreset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilmPresetCopyWith<_FilmPreset> get copyWith => __$FilmPresetCopyWithImpl<_FilmPreset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilmPresetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilmPreset&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isBuiltIn, isBuiltIn) || other.isBuiltIn == isBuiltIn)&&(identical(other.exposure, exposure) || other.exposure == exposure)&&(identical(other.temperatureK, temperatureK) || other.temperatureK == temperatureK)&&(identical(other.tint, tint) || other.tint == tint)&&(identical(other.contrast, contrast) || other.contrast == contrast)&&(identical(other.saturation, saturation) || other.saturation == saturation)&&(identical(other.fade, fade) || other.fade == fade)&&(identical(other.shadowTintColor, shadowTintColor) || other.shadowTintColor == shadowTintColor)&&(identical(other.shadowTintStrength, shadowTintStrength) || other.shadowTintStrength == shadowTintStrength)&&(identical(other.highlightTintColor, highlightTintColor) || other.highlightTintColor == highlightTintColor)&&(identical(other.highlightTintStrength, highlightTintStrength) || other.highlightTintStrength == highlightTintStrength)&&(identical(other.lutAsset, lutAsset) || other.lutAsset == lutAsset)&&(identical(other.lutIntensity, lutIntensity) || other.lutIntensity == lutIntensity)&&(identical(other.grain, grain) || other.grain == grain)&&(identical(other.grainSize, grainSize) || other.grainSize == grainSize)&&(identical(other.vignette, vignette) || other.vignette == vignette)&&(identical(other.halation, halation) || other.halation == halation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,isBuiltIn,exposure,temperatureK,tint,contrast,saturation,fade,shadowTintColor,shadowTintStrength,highlightTintColor,highlightTintStrength,lutAsset,lutIntensity,grain,grainSize,vignette,halation]);

@override
String toString() {
  return 'FilmPreset(id: $id, name: $name, isBuiltIn: $isBuiltIn, exposure: $exposure, temperatureK: $temperatureK, tint: $tint, contrast: $contrast, saturation: $saturation, fade: $fade, shadowTintColor: $shadowTintColor, shadowTintStrength: $shadowTintStrength, highlightTintColor: $highlightTintColor, highlightTintStrength: $highlightTintStrength, lutAsset: $lutAsset, lutIntensity: $lutIntensity, grain: $grain, grainSize: $grainSize, vignette: $vignette, halation: $halation)';
}


}

/// @nodoc
abstract mixin class _$FilmPresetCopyWith<$Res> implements $FilmPresetCopyWith<$Res> {
  factory _$FilmPresetCopyWith(_FilmPreset value, $Res Function(_FilmPreset) _then) = __$FilmPresetCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool isBuiltIn, double exposure, double temperatureK, double tint, double contrast, double saturation, double fade, int shadowTintColor, double shadowTintStrength, int highlightTintColor, double highlightTintStrength, String? lutAsset, double lutIntensity, double grain, double grainSize, double vignette, double halation
});




}
/// @nodoc
class __$FilmPresetCopyWithImpl<$Res>
    implements _$FilmPresetCopyWith<$Res> {
  __$FilmPresetCopyWithImpl(this._self, this._then);

  final _FilmPreset _self;
  final $Res Function(_FilmPreset) _then;

/// Create a copy of FilmPreset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isBuiltIn = null,Object? exposure = null,Object? temperatureK = null,Object? tint = null,Object? contrast = null,Object? saturation = null,Object? fade = null,Object? shadowTintColor = null,Object? shadowTintStrength = null,Object? highlightTintColor = null,Object? highlightTintStrength = null,Object? lutAsset = freezed,Object? lutIntensity = null,Object? grain = null,Object? grainSize = null,Object? vignette = null,Object? halation = null,}) {
  return _then(_FilmPreset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isBuiltIn: null == isBuiltIn ? _self.isBuiltIn : isBuiltIn // ignore: cast_nullable_to_non_nullable
as bool,exposure: null == exposure ? _self.exposure : exposure // ignore: cast_nullable_to_non_nullable
as double,temperatureK: null == temperatureK ? _self.temperatureK : temperatureK // ignore: cast_nullable_to_non_nullable
as double,tint: null == tint ? _self.tint : tint // ignore: cast_nullable_to_non_nullable
as double,contrast: null == contrast ? _self.contrast : contrast // ignore: cast_nullable_to_non_nullable
as double,saturation: null == saturation ? _self.saturation : saturation // ignore: cast_nullable_to_non_nullable
as double,fade: null == fade ? _self.fade : fade // ignore: cast_nullable_to_non_nullable
as double,shadowTintColor: null == shadowTintColor ? _self.shadowTintColor : shadowTintColor // ignore: cast_nullable_to_non_nullable
as int,shadowTintStrength: null == shadowTintStrength ? _self.shadowTintStrength : shadowTintStrength // ignore: cast_nullable_to_non_nullable
as double,highlightTintColor: null == highlightTintColor ? _self.highlightTintColor : highlightTintColor // ignore: cast_nullable_to_non_nullable
as int,highlightTintStrength: null == highlightTintStrength ? _self.highlightTintStrength : highlightTintStrength // ignore: cast_nullable_to_non_nullable
as double,lutAsset: freezed == lutAsset ? _self.lutAsset : lutAsset // ignore: cast_nullable_to_non_nullable
as String?,lutIntensity: null == lutIntensity ? _self.lutIntensity : lutIntensity // ignore: cast_nullable_to_non_nullable
as double,grain: null == grain ? _self.grain : grain // ignore: cast_nullable_to_non_nullable
as double,grainSize: null == grainSize ? _self.grainSize : grainSize // ignore: cast_nullable_to_non_nullable
as double,vignette: null == vignette ? _self.vignette : vignette // ignore: cast_nullable_to_non_nullable
as double,halation: null == halation ? _self.halation : halation // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
