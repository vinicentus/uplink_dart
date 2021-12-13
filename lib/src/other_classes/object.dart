import 'dart:ffi';

import 'package:storj_dart/generated/generated_bindings.dart';
import 'package:storj_dart/src/helpers.dart';

/// Dart wrapper for [UplinkObject].
/// This exists because it has more convenient types than the underlying
/// [UplinkObject]. This also eliminates the need to use and dereference
/// pointers from outside this library.
// TODO: rename
// TODO: preferrably we could find some way to avoid creating these dart classes for small structs
class DartUplinkObject {
  final Pointer<UplinkObject> _nativeObject;
  // This should only ever be constructed from within onther classes in
  // this library, so taking a Struct is fine.
  // TODO: convert to private constructor that is only accessible from within library
  DartUplinkObject(this._nativeObject);

  String get key => _nativeObject.ref.key.int8PointerToString();
  // This essentially converts an Uint8 with value 1 or 0 to a boolean
  bool get isPrefix => _nativeObject.ref.is_prefix == 1;
  UplinkSystemMetadata get system => _nativeObject.ref.system;
  UplinkCustomMetadata get custom => _nativeObject.ref.custom;
}
