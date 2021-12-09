import 'package:storj_dart/generated_bindings.dart';
import 'package:storj_dart/storj_dart.dart';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

void main() {
  var awesome = Awesome();
  print('awesome: ${awesome.isAwesome}');

  var lib = NativeLibrary(DynamicLibrary.open('libuplinkc.so'));

  var dartAccessString = 'example';
  var charPointer = dartAccessString.toNativeUtf8();
  var intPointer = charPointer.cast<Int8>();
  UplinkAccessResult accessResult = lib.uplink_parse_access(intPointer);
  Pointer<UplinkError> errorPointer = accessResult.error;
  UplinkError errorStruct = errorPointer.ref;
  print(errorStruct.code);
  var errorMessage = errorStruct.message.cast<Utf8>().toDartString();
  print(errorMessage);
}
