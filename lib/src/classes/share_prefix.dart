part of classes;

class DartUplinkUplinkSharePrefix
    extends StructWrapper<bindings.UplinkSharePrefix> {
  @override
  DartUplinkUplinkSharePrefix._fromNative(
      Pointer<bindings.UplinkSharePrefix> _native)
      : super._fromNative(_native);

  String get bucket => _native.ref.bucket.int8PointerToString();

  String get prefix => _native.ref.prefix.int8PointerToString();

  DartUplinkUplinkSharePrefix(String bucket, String prefix)
      : super._fromNative(calloc.call<bindings.UplinkSharePrefix>()) {
    // TODO: does this work, or does this only change on the dart side?
    _native.ref.bucket = bucket.stringToInt8Pointer();
    _native.ref.prefix = prefix.stringToInt8Pointer();
  }
}
