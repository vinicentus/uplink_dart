part of classes;

// TODO: add setters
class DartUplinkBucket extends StructWrapper<bindings.UplinkBucket> {
  @override
  DartUplinkBucket._fromNative(Pointer<bindings.UplinkBucket> _native)
      : super._fromNative(_native);

  String get name => _native.ref.name.int8PointerToString();

  DateTime get created => _native.ref.created.convertToDateTime();
}
