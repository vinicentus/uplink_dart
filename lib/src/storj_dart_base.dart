import 'dart:typed_data';

import 'package:storj_dart/generated/generated_bindings.dart';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

// TODO: Put public facing types in this file.

class Uplink {
  final _lib = NativeLibrary(DynamicLibrary.open('libuplinkc.so'));

  Pointer<UplinkAccess> parseAccess(String access) {
    var intPointer = _stringToInt8Pointer(access);
    UplinkAccessResult accessResult = _lib.uplink_parse_access(intPointer);

    calloc.free(intPointer);

    _throwIfError(accessResult.error);
    return accessResult.access;
  }

  Pointer<UplinkProject> openProject(Pointer<UplinkAccess> access) {
    var result = _lib.uplink_open_project(access);

    _throwIfError(result.error);
    return result.project;
  }

  Pointer<UplinkDownload> downloadObject(
      Pointer<UplinkProject> project, String bucketName, String path,
      [Pointer<UplinkDownloadOptions>? downloadOptions]) {
    // If no downloadOptions are passed, we have to allocate
    // This is the same as calloc.allocate(sizeOf<UplinkDownloadOptions>());
    // downloadOptions ??= calloc.call<UplinkDownloadOptions>();
    downloadOptions ??= nullptr;

    var bucketNameInt = _stringToInt8Pointer(bucketName);
    var pahtInt = _stringToInt8Pointer(path);
    var result = _lib.uplink_download_object(
        project, bucketNameInt, pahtInt, downloadOptions);

    calloc.free(bucketNameInt);
    calloc.free(pahtInt);
    calloc.free(downloadOptions);

    _throwIfError(result.error);
    return result.download;
  }

  Uint8List downloadRead(Pointer<UplinkDownload> download, int allowedLength) {
    // Allocate a limited length pointer for the returned data
    var downloadedData = calloc.allocate<Void>(allowedLength);

    var result =
        _lib.uplink_download_read(download, downloadedData, allowedLength);

    // TODO: this now throws even if the read was a partial success.
    // For example, if the allowed length to read is shorter than the data available.
    // Some data might be read, but never returned, because this throws instead.
    // The original implementation returns both the partial data and the error in a struct.
    _throwIfError(result.error);

    var returnList = Uint8List.fromList(
        downloadedData.cast<Int8>().asTypedList(allowedLength));
    calloc.free(downloadedData);

    // TODO: return result.bytes_read as well
    return returnList;
  }

  void _throwIfError(Pointer<UplinkError> error) {
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

  Pointer<Int8> _stringToInt8Pointer(String string) {
    var charPointer = string.toNativeUtf8();
    return charPointer.cast<Int8>();
  }

  String _int8PointerToString(Pointer<Int8> pointer) {
    var charPointer = pointer.cast<Utf8>();
    // TODO: check that the length of the returned string is correct
    return charPointer.toDartString();
  }
}

extension NullPtrCheck on Pointer {
  bool isNullPtr() => address == nullptr.address;
}
