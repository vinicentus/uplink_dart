part of classes;

class DartUplinkUpload {
  final bindings.NativeLibrary _nativeLib;
  late final Pointer<bindings.UplinkUpload> _nativeUpload;

  DartUplinkUpload._fromNative(this._nativeUpload)
      : _nativeLib = _nativeLibrary;

  // TODO: add methods
}
