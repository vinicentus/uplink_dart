part of classes;

class DartUplinkPartUpload {
  final NativeLibrary _nativeLib;
  late final Pointer<UplinkPartUpload> _nativePartUpload;

  DartUplinkPartUpload._fromNative(this._nativePartUpload)
      : _nativeLib = _nativeLibrary;
}
