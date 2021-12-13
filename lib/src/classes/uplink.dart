part of classes;

/// This class exist only to instanciate objects of the other classes.
/// It also serves to save the reference of the [NativeLibrary].
/// The plan is to convert all the methods of this class into constructors
/// for the types that they currently return.
/// GetIt or similar can be used for keeping a reference th the [NativeLibrary]
/// when we get that far.
class Uplink {
  final _lib = _nativeLibrary;

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
