part of classes;

class DartUplinkDownload extends StructWrapper<bindings.UplinkDownload>
    with NativeLib {
  @override
  DartUplinkDownload._fromNative(Pointer<bindings.UplinkDownload> _native)
      : super._fromNative(_native);

  void close() {
    var error = _nativeLibrary.uplink_close_download(_native);
    throwIfError(error);
  }

  DartUplinkObject info() {
    var result = _nativeLibrary.uplink_download_info(_native);

    throwIfError(result.error);
    return DartUplinkObject._fromNative(result.object);
  }

  /// The original go implementation of this returns the number of bytes read as well as the data.
  /// This version, however, returns only a list of bytes, but you can easily call ".length" on that list.
  /// This length of the returned list is guaranteed to be the same length as the number of bytes read.
  /// When using this function, you need to take care to check the length of he returned list,
  /// because the number of bytes read and returned might be fewer than requested.
  // TODO: also make a stream version of this somewhere
  // TODO: check why this sometimes return less data than requested, even though there is more data available
  Uint8List read(int length) {
    // Allocate a limited length pointer for the returned data.
    // We use malloc here, which doesn't zero out the memory section.
    // That should not be needed, since we will be writing over most of it,
    // and discarding any trailing bytes that were not overwritten
    var downloadedData = malloc.allocate<Void>(length);

    var result =
        _nativeLibrary.uplink_download_read(_native, downloadedData, length);

    // TODO: this now throws even if the read was a partial success.
    // For example, if the allowed length to read is shorter than the data available.
    // Some data might be read, but never returned, because this throws instead.
    // The original implementation returns both the partial data and the error in a struct.
    throwIfError(result.error);

    // Important! Only return the read bytes, truncate list to remove trailing zeroes
    var returnList = Uint8List.fromList(
        downloadedData.cast<Uint8>().asTypedList(result.bytes_read));
    calloc.free(downloadedData);

    return returnList;
  }
}
