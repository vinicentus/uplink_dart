part of classes;

class DartUplinkAccess extends StructWrapper<bindings.UplinkAccess>
    with NativeLib {
  @override
  DartUplinkAccess._fromNative(_native) : super._fromNative(_native);

  DartUplinkAccess.parseAccess(String access) {
    var intPointer = access.stringToInt8Pointer();
    var result = _nativeLibrary.uplink_parse_access(intPointer);

    // TODO: make sure this value isn't needed anymore
    calloc.free(intPointer);

    throwIfError(result.error);
    _native = result.access;
  }

  DartUplinkAccess.requestAccessWithPassPhrase() {
    throw UnimplementedError();
  }

  overrideEncryptionkey() {
    throw UnimplementedError();
  }

  satelliteAddress() {
    throw UnimplementedError();
  }

  String serialize() {
    var result = _nativeLibrary.uplink_access_serialize(_native);

    throwIfError(result.error);
    return result.string.int8PointerToString();
  }

  // TODO: decide how to handle duplicate sharePrefixes (see if it is handled in C, and maybe convert to Set or check for duplicates)
  DartUplinkAccess share(DartUplinkPermission permission,
      List<DartUplinkUplinkSharePrefix> sharePrefixes) {
    var sharePrefixesPointer =
        malloc.call<bindings.UplinkSharePrefix>(sharePrefixes.length);
    // TODO: This probably will not work
    for (int i = 0; i < sharePrefixes.length; i++) {
      var actualPointer = sharePrefixesPointer.elementAt(i);
      actualPointer.ref.bucket = sharePrefixes[i]._native.ref.bucket;
      actualPointer.ref.prefix = sharePrefixes[i]._native.ref.prefix;
    }

    var result = _nativeLibrary.uplink_access_share(_native,
        permission._native.ref, sharePrefixesPointer, sharePrefixes.length);

    throwIfError(result.error);
    return DartUplinkAccess._fromNative(result.access);
  }
}
