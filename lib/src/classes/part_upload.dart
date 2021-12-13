part of classes;

class DartUplinkPartUpload {
  final bindings.NativeLibrary _nativeLib;
  late final Pointer<bindings.UplinkPartUpload> _nativePartUpload;

  DartUplinkPartUpload._fromNative(this._nativePartUpload)
      : _nativeLib = _nativeLibrary;

  // TODO: add methods
}
