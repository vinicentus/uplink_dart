import 'dart:ffi';

import 'package:ffi/ffi.dart';

extension StringHelpers on String {
  Pointer<Int8> stringToInt8Pointer() => toNativeUtf8().cast<Int8>();
}

extension PointerHelpers on Pointer {
  bool isNullPtr() => address == nullptr.address;
}

extension Int8Helpers on Pointer<Int8> {
  // TODO: check that the length of the returned string is correct
  String int8PointerToString() => cast<Utf8>().toDartString();
}
