import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:storj_dart/generated/generated_bindings.dart';

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

void throwIfError(Pointer<UplinkError> error) {
  if (error.isNullPtr()) {
    // This is a nullptr
    print(
        'Nullpointer encounted, we shouldn\'t try to do anything with the value of this pointer...');
    return;
  }

  var actualError = error.ref;

  if (!actualError.message.isNullPtr()) {
    var errorMessage = actualError.message.cast<Utf8>().toDartString();
    throw Exception([actualError.code, errorMessage]);
  } else {
    throw Exception(actualError.code);
  }
}
