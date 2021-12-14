part of classes;

// TODO: allow users to free this
class DartUplinkDownloadOptions
    extends StructWrapper<bindings.UplinkDownloadOptions> {
  @override
  DartUplinkDownloadOptions._fromNative(
      Pointer<bindings.UplinkDownloadOptions> _native)
      : super._fromNative(_native);

  int get offset => _native.ref.offset;
  int get length => _native.ref.length;

  DartUplinkDownloadOptions(int offset, int length) {
    _native = calloc.call<bindings.UplinkDownloadOptions>();
    _native.ref.offset = offset;
    _native.ref.length = length;
  }
}
