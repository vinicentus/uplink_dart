import 'package:storj_dart/generated_bindings.dart';
import 'package:storj_dart/storj_dart.dart';
import 'dart:ffi' as ffi;

void main() {
  var awesome = Awesome();
  print('awesome: ${awesome.isAwesome}');

  var lib = NativeLibrary(ffi.DynamicLibrary.open('libuplinkc.so'));

  // UplinkAccessResult access = lib.uplink_parse_access(accessString);
}
