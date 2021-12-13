library classes;

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:storj_dart/generated/generated_bindings.dart';
import 'package:storj_dart/src/helpers.dart';
import 'package:storj_dart/src/other_classes/object.dart';

part './access.dart';
part './project.dart';
part './download.dart';

// TODO: maybe move to custom singleton or use  service lcoator such as GetIt?
var _nativeLibrary = NativeLibrary(DynamicLibrary.open('libuplinkc.so'));
