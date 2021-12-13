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
    throw UnimplementedError();
  }

  share() {
    throw UnimplementedError();
  }
}
