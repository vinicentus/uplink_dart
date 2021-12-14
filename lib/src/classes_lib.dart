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

// TODO: maybe move to custom singleton or use  service locator such as GetIt?
late final bindings.NativeLibrary _nativeLib;

/// This function must be called before using any of the classes provided by this library.
/// It loads the uplink dynamic library so that this dart library can depend on it.
/// Currently this library needs to be loaded from a path on your filesystem,
/// and loading from a rootBundle or AssetBundle is not supported.
/// The path can be relative or absolute.
void loadDynamicLibrary(String path) {
  _nativeLib = bindings.NativeLibrary(DynamicLibrary.open(path));
}

mixin NativeLib {
  bindings.NativeLibrary get _nativeLibrary => _nativeLib;
}
