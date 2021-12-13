library classes;

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:storj_dart/generated/generated_bindings.dart' as bindings;
import 'package:storj_dart/src/helpers.dart';

part 'struct_wrapper.dart'; // Abstract class needed for essentialy all other classes
part 'classes/access.dart';
part 'classes/project.dart';
part 'classes/download.dart';
part 'classes/encryption_key.dart';
part 'classes/upload.dart';
part 'classes/part_upload.dart';
part 'classes/permission.dart';
part 'classes/share_prefix.dart';
part 'classes/object.dart';

// TODO: maybe move to custom singleton or use  service lcoator such as GetIt?
var _nativeLib = bindings.NativeLibrary(DynamicLibrary.open('libuplinkc.so'));

mixin NativeLib {
  final bindings.NativeLibrary _nativeLibrary = _nativeLib;
}
