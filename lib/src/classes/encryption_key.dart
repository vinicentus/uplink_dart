part of classes;

class DartUplinkEncryptionKey {
  final bindings.NativeLibrary _nativeLib;
  late final Pointer<bindings.UplinkEncryptionKey> _nativeEncryptionKey;

  DartUplinkEncryptionKey._fromNative(this._nativeEncryptionKey)
      : _nativeLib = _nativeLibrary;

  DartUplinkEncryptionKey.deriveEncryptionKey(String passphrase, Uint8List salt)
      : _nativeLib = _nativeLibrary {
    throw UnimplementedError();
  }
}
