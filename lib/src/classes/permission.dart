part of classes;

/// This class currently doesn't expose any setters, so new instances are used instead of changing values.
/// TODO: expose setters for values.
// TODO: Add tests (especially for constructors because they aren't defined in uplink-c but only in go), since this is a critical part of the library
class DartUplinkPermission {
  late final Pointer<bindings.UplinkPermission> _nativeUplinkPermission;

  bool get allowDownload =>
      _nativeUplinkPermission.ref.allow_download.convertToBool();
  bool get allowUpload =>
      _nativeUplinkPermission.ref.allow_upload.convertToBool();
  bool get allowList => _nativeUplinkPermission.ref.allow_list.convertToBool();
  bool get allowDelete =>
      _nativeUplinkPermission.ref.allow_delete.convertToBool();

  /// Return null when not used, the original library returns 0;
  DateTime? get notBefore => _nativeUplinkPermission.ref.not_before == 0
      ? null
      : DateTime.fromMillisecondsSinceEpoch(
          _nativeUplinkPermission.ref.not_before * 1000);

  /// Return null when not used, the original library returns 0;
  DateTime? get notAfter => _nativeUplinkPermission.ref.not_after == 0
      ? null
      : DateTime.fromMillisecondsSinceEpoch(
          _nativeUplinkPermission.ref.not_after * 1000);

  DartUplinkPermission._fromNative(this._nativeUplinkPermission);

  DartUplinkPermission.fullPermission()
      : _nativeUplinkPermission = calloc.call<bindings.UplinkPermission>() {
    _nativeUplinkPermission.ref.allow_download = true.convertToInt();
    _nativeUplinkPermission.ref.allow_upload = true.convertToInt();
    _nativeUplinkPermission.ref.allow_list = true.convertToInt();
    _nativeUplinkPermission.ref.allow_delete = true.convertToInt();
  }

  DartUplinkPermission.readOnlyPermission()
      : _nativeUplinkPermission = calloc.call<bindings.UplinkPermission>() {
    _nativeUplinkPermission.ref.allow_download = true.convertToInt();
    _nativeUplinkPermission.ref.allow_list = true.convertToInt();
  }

  DartUplinkPermission.writeOnlyPermission() {
    _nativeUplinkPermission.ref.allow_upload = true.convertToInt();
    _nativeUplinkPermission.ref.allow_delete = true.convertToInt();
  }
}
