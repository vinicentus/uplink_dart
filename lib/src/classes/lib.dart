library classes;

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:storj_dart/generated/generated_bindings.dart' as bindings;
import 'package:storj_dart/src/helpers.dart';
import 'package:storj_dart/src/other_classes/object.dart';

part 'struct_wrapper.dart'; // Abstract class needed for essentialy all other classes
part 'access.dart';
part 'project.dart';
part 'download.dart';
part 'encryption_key.dart';
part 'upload.dart';
part 'part_upload.dart';
part 'permission.dart';
part 'share_prefix.dart';

// TODO: maybe move to custom singleton or use  service lcoator such as GetIt?
var _nativeLib = bindings.NativeLibrary(DynamicLibrary.open('libuplinkc.so'));

mixin NativeLib {
  final bindings.NativeLibrary _nativeLibrary = _nativeLib;
}
