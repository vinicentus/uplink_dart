part of classes;

class DartUplinkEncryptionKey
    extends StructWrapper<bindings.UplinkEncryptionKey> {
  @override
  DartUplinkEncryptionKey._fromNative(
      Pointer<bindings.UplinkEncryptionKey> _native)
      : super._fromNative(_native);

  DartUplinkEncryptionKey.deriveEncryptionKey(
      String passphrase, Uint8List salt) {
    throw UnimplementedError();
  }
}
