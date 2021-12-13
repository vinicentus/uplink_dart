part of classes;

class DartUplinkAccess {
  final NativeLibrary _nativeLib;
  // This is late because we need to call a c function to get a reference in the constructor
  late final Pointer<UplinkAccess> _nativeAccess;

  DartUplinkAccess._fromNative(this._nativeAccess)
      : _nativeLib = _nativeLibrary;

  DartUplinkAccess.parseAccess(String access) : _nativeLib = _nativeLibrary {
    var intPointer = access.stringToInt8Pointer();
    var result = _nativeLib.uplink_parse_access(intPointer);

    // TODO: make sure this value isn't needed anymore
    calloc.free(intPointer);

    throwIfError(result.error);
    _nativeAccess = result.access;
  }

  DartUplinkAccess.requestAccessWithPassPhrase() : _nativeLib = _nativeLibrary {
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
