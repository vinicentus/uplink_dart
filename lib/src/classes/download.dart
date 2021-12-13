part of classes;

class DartUplinkDownload {
  final NativeLibrary _nativeLib;
  late final Pointer<UplinkDownload> _nativeDownload;

  DartUplinkDownload._fromNative(this._nativeDownload)
      : _nativeLib = _nativeLibrary;

  close() {
    throw UnimplementedError();
  }

  DartUplinkObject info() {
    var result = _nativeLib.uplink_download_info(_nativeDownload);

    throwIfError(result.error);
    return DartUplinkObject(result.object);
  }

  /// The original go implementation of this returns the number of bytes read as well as the data.
  /// This version, however, returns only a list of bytes, but you can easily call ".length" on that list.
  // TODO: make this more similar to the go version, but still return a useful dart type.
  // TODO: also make a stream version of this somewhere
  Uint8List read(int length) {
    // Allocate a limited length pointer for the returned data
    var downloadedData = calloc.allocate<Void>(length);

    var result = _nativeLib.uplink_download_read(
        _nativeDownload, downloadedData, length);

    // TODO: this now throws even if the read was a partial success.
    // For example, if the allowed length to read is shorter than the data available.
    // Some data might be read, but never returned, because this throws instead.
    // The original implementation returns both the partial data and the error in a struct.
    throwIfError(result.error);

    var returnList =
        Uint8List.fromList(downloadedData.cast<Int8>().asTypedList(length));
    calloc.free(downloadedData);

    return returnList;
  }
}
