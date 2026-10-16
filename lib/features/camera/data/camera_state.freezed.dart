// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CameraState {

 CameraController get controller; List<CameraDescription> get cameras; int get cameraIndex; FlashMode get flashMode; double get exposureOffset; double get minExposureOffset; double get maxExposureOffset; double get zoom; double get minZoom; double get maxZoom;
/// Create a copy of CameraState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraStateCopyWith<CameraState> get copyWith => _$CameraStateCopyWithImpl<CameraState>(this as CameraState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CameraState&&(identical(other.controller, controller) || other.controller == controller)&&const DeepCollectionEquality().equals(other.cameras, cameras)&&(identical(other.cameraIndex, cameraIndex) || other.cameraIndex == cameraIndex)&&(identical(other.flashMode, flashMode) || other.flashMode == flashMode)&&(identical(other.exposureOffset, exposureOffset) || other.exposureOffset == exposureOffset)&&(identical(other.minExposureOffset, minExposureOffset) || other.minExposureOffset == minExposureOffset)&&(identical(other.maxExposureOffset, maxExposureOffset) || other.maxExposureOffset == maxExposureOffset)&&(identical(other.zoom, zoom) || other.zoom == zoom)&&(identical(other.minZoom, minZoom) || other.minZoom == minZoom)&&(identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom));
}


@override
int get hashCode => Object.hash(runtimeType,controller,const DeepCollectionEquality().hash(cameras),cameraIndex,flashMode,exposureOffset,minExposureOffset,maxExposureOffset,zoom,minZoom,maxZoom);

@override
String toString() {
  return 'CameraState(controller: $controller, cameras: $cameras, cameraIndex: $cameraIndex, flashMode: $flashMode, exposureOffset: $exposureOffset, minExposureOffset: $minExposureOffset, maxExposureOffset: $maxExposureOffset, zoom: $zoom, minZoom: $minZoom, maxZoom: $maxZoom)';
}


}

/// @nodoc
abstract mixin class $CameraStateCopyWith<$Res>  {
  factory $CameraStateCopyWith(CameraState value, $Res Function(CameraState) _then) = _$CameraStateCopyWithImpl;
@useResult
$Res call({
 CameraController controller, List<CameraDescription> cameras, int cameraIndex, FlashMode flashMode, double exposureOffset, double minExposureOffset, double maxExposureOffset, double zoom, double minZoom, double maxZoom
});




}
/// @nodoc
class _$CameraStateCopyWithImpl<$Res>
    implements $CameraStateCopyWith<$Res> {
  _$CameraStateCopyWithImpl(this._self, this._then);

  final CameraState _self;
  final $Res Function(CameraState) _then;

/// Create a copy of CameraState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? controller = null,Object? cameras = null,Object? cameraIndex = null,Object? flashMode = null,Object? exposureOffset = null,Object? minExposureOffset = null,Object? maxExposureOffset = null,Object? zoom = null,Object? minZoom = null,Object? maxZoom = null,}) {
  return _then(CameraState(
controller: null == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as CameraController,cameras: null == cameras ? _self.cameras : cameras // ignore: cast_nullable_to_non_nullable
as List<CameraDescription>,cameraIndex: null == cameraIndex ? _self.cameraIndex : cameraIndex // ignore: cast_nullable_to_non_nullable
as int,flashMode: null == flashMode ? _self.flashMode : flashMode // ignore: cast_nullable_to_non_nullable
as FlashMode,exposureOffset: null == exposureOffset ? _self.exposureOffset : exposureOffset // ignore: cast_nullable_to_non_nullable
as double,minExposureOffset: null == minExposureOffset ? _self.minExposureOffset : minExposureOffset // ignore: cast_nullable_to_non_nullable
as double,maxExposureOffset: null == maxExposureOffset ? _self.maxExposureOffset : maxExposureOffset // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,minZoom: null == minZoom ? _self.minZoom : minZoom // ignore: cast_nullable_to_non_nullable
as double,maxZoom: null == maxZoom ? _self.maxZoom : maxZoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CameraState].
extension CameraStatePatterns on CameraState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CameraState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CameraState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CameraState value)  $default,){
final _that = this;
switch (_that) {
case _CameraState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CameraState value)?  $default,){
final _that = this;
switch (_that) {
case _CameraState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CameraController controller,  List<CameraDescription> cameras,  int cameraIndex,  FlashMode flashMode,  double exposureOffset,  double minExposureOffset,  double maxExposureOffset,  double zoom,  double minZoom,  double maxZoom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CameraState() when $default != null:
return $default(_that.controller,_that.cameras,_that.cameraIndex,_that.flashMode,_that.exposureOffset,_that.minExposureOffset,_that.maxExposureOffset,_that.zoom,_that.minZoom,_that.maxZoom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CameraController controller,  List<CameraDescription> cameras,  int cameraIndex,  FlashMode flashMode,  double exposureOffset,  double minExposureOffset,  double maxExposureOffset,  double zoom,  double minZoom,  double maxZoom)  $default,) {final _that = this;
switch (_that) {
case _CameraState():
return $default(_that.controller,_that.cameras,_that.cameraIndex,_that.flashMode,_that.exposureOffset,_that.minExposureOffset,_that.maxExposureOffset,_that.zoom,_that.minZoom,_that.maxZoom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CameraController controller,  List<CameraDescription> cameras,  int cameraIndex,  FlashMode flashMode,  double exposureOffset,  double minExposureOffset,  double maxExposureOffset,  double zoom,  double minZoom,  double maxZoom)?  $default,) {final _that = this;
switch (_that) {
case _CameraState() when $default != null:
return $default(_that.controller,_that.cameras,_that.cameraIndex,_that.flashMode,_that.exposureOffset,_that.minExposureOffset,_that.maxExposureOffset,_that.zoom,_that.minZoom,_that.maxZoom);case _:
  return null;

}
}

}

/// @nodoc


class _CameraState implements CameraState {
  const _CameraState({required this.controller, required  List<CameraDescription> cameras, required this.cameraIndex, this.flashMode = FlashMode.off, this.exposureOffset = 0, required this.minExposureOffset, required this.maxExposureOffset, this.zoom = 1, required this.minZoom, required this.maxZoom}): _cameras = cameras;
  

@override final  CameraController controller;
 final  List<CameraDescription> _cameras;
@override List<CameraDescription> get cameras {
  if (_cameras is EqualUnmodifiableListView) return _cameras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cameras);
}

@override final  int cameraIndex;
@override@JsonKey() final  FlashMode flashMode;
@override@JsonKey() final  double exposureOffset;
@override final  double minExposureOffset;
@override final  double maxExposureOffset;
@override@JsonKey() final  double zoom;
@override final  double minZoom;
@override final  double maxZoom;

/// Create a copy of CameraState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CameraStateCopyWith<_CameraState> get copyWith => __$CameraStateCopyWithImpl<_CameraState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraState&&(identical(other.controller, controller) || other.controller == controller)&&const DeepCollectionEquality().equals(other._cameras, _cameras)&&(identical(other.cameraIndex, cameraIndex) || other.cameraIndex == cameraIndex)&&(identical(other.flashMode, flashMode) || other.flashMode == flashMode)&&(identical(other.exposureOffset, exposureOffset) || other.exposureOffset == exposureOffset)&&(identical(other.minExposureOffset, minExposureOffset) || other.minExposureOffset == minExposureOffset)&&(identical(other.maxExposureOffset, maxExposureOffset) || other.maxExposureOffset == maxExposureOffset)&&(identical(other.zoom, zoom) || other.zoom == zoom)&&(identical(other.minZoom, minZoom) || other.minZoom == minZoom)&&(identical(other.maxZoom, maxZoom) || other.maxZoom == maxZoom));
}


@override
int get hashCode => Object.hash(runtimeType,controller,const DeepCollectionEquality().hash(_cameras),cameraIndex,flashMode,exposureOffset,minExposureOffset,maxExposureOffset,zoom,minZoom,maxZoom);

@override
String toString() {
  return 'CameraState(controller: $controller, cameras: $cameras, cameraIndex: $cameraIndex, flashMode: $flashMode, exposureOffset: $exposureOffset, minExposureOffset: $minExposureOffset, maxExposureOffset: $maxExposureOffset, zoom: $zoom, minZoom: $minZoom, maxZoom: $maxZoom)';
}


}

/// @nodoc
abstract mixin class _$CameraStateCopyWith<$Res> implements $CameraStateCopyWith<$Res> {
  factory _$CameraStateCopyWith(_CameraState value, $Res Function(_CameraState) _then) = __$CameraStateCopyWithImpl;
@override @useResult
$Res call({
 CameraController controller, List<CameraDescription> cameras, int cameraIndex, FlashMode flashMode, double exposureOffset, double minExposureOffset, double maxExposureOffset, double zoom, double minZoom, double maxZoom
});




}
/// @nodoc
class __$CameraStateCopyWithImpl<$Res>
    implements _$CameraStateCopyWith<$Res> {
  __$CameraStateCopyWithImpl(this._self, this._then);

  final _CameraState _self;
  final $Res Function(_CameraState) _then;

/// Create a copy of CameraState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? controller = null,Object? cameras = null,Object? cameraIndex = null,Object? flashMode = null,Object? exposureOffset = null,Object? minExposureOffset = null,Object? maxExposureOffset = null,Object? zoom = null,Object? minZoom = null,Object? maxZoom = null,}) {
  return _then(_CameraState(
controller: null == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as CameraController,cameras: null == cameras ? _self._cameras : cameras // ignore: cast_nullable_to_non_nullable
as List<CameraDescription>,cameraIndex: null == cameraIndex ? _self.cameraIndex : cameraIndex // ignore: cast_nullable_to_non_nullable
as int,flashMode: null == flashMode ? _self.flashMode : flashMode // ignore: cast_nullable_to_non_nullable
as FlashMode,exposureOffset: null == exposureOffset ? _self.exposureOffset : exposureOffset // ignore: cast_nullable_to_non_nullable
as double,minExposureOffset: null == minExposureOffset ? _self.minExposureOffset : minExposureOffset // ignore: cast_nullable_to_non_nullable
as double,maxExposureOffset: null == maxExposureOffset ? _self.maxExposureOffset : maxExposureOffset // ignore: cast_nullable_to_non_nullable
as double,zoom: null == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double,minZoom: null == minZoom ? _self.minZoom : minZoom // ignore: cast_nullable_to_non_nullable
as double,maxZoom: null == maxZoom ? _self.maxZoom : maxZoom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
