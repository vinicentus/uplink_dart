import 'dart:typed_data';

import 'package:storj_dart/generated/generated_bindings.dart';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:storj_dart/src/classes/object.dart';
import 'package:storj_dart/src/classes/project.dart';
import 'package:storj_dart/src/helpers.dart';

// TODO: Put public facing types in this file.

class Uplink {
  final _lib = NativeLibrary(DynamicLibrary.open('libuplinkc.so'));

  // TODO: change return type?
  Pointer<UplinkAccess> parseAccess(String access) {
    var intPointer = access.stringToInt8Pointer();
    UplinkAccessResult accessResult = _lib.uplink_parse_access(intPointer);

    calloc.free(intPointer);

    throwIfError(accessResult.error);
    return accessResult.access;
  }

  DartUplinkProject openProject(Pointer<UplinkAccess> access) {
    var result = _lib.uplink_open_project(access);

    throwIfError(result.error);
    return DartUplinkProject(result.project, _lib);
  }

  // TODO: move to separate class
  DartUplinkObject downloadInfo(Pointer<UplinkDownload> download) {
    var result = _lib.uplink_download_info(download);

    throwIfError(result.error);

    return DartUplinkObject(result.object);
  }

  // TODO: move to separate class
  Uint8List downloadRead(Pointer<UplinkDownload> download, int allowedLength) {
    // Allocate a limited length pointer for the returned data
    var downloadedData = calloc.allocate<Void>(allowedLength);

    var result =
        _lib.uplink_download_read(download, downloadedData, allowedLength);

    // TODO: this now throws even if the read was a partial success.
    // For example, if the allowed length to read is shorter than the data available.
    // Some data might be read, but never returned, because this throws instead.
    // The original implementation returns both the partial data and the error in a struct.
    throwIfError(result.error);

    var returnList = Uint8List.fromList(
        downloadedData.cast<Int8>().asTypedList(allowedLength));
    calloc.free(downloadedData);

    // TODO: return result.bytes_read as well
    return returnList;
  }
}
