part of classes;

class DartUplinkUpload {
  final NativeLibrary _nativeLib;
  late final Pointer<UplinkUpload> _nativeUpload;

  DartUplinkUpload._fromNative(this._nativeUpload)
      : _nativeLib = _nativeLibrary;
}
