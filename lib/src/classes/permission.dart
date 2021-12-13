part of classes;

/// This class currently doesn't expose any setters, so new instances are used instead of changing values.
/// TODO: expose setters for values.
// TODO: Add tests (especially for constructors because they aren't defined in uplink-c but only in go), since this is a critical part of the library
class DartUplinkPermission extends StructWrapper<bindings.UplinkPermission> {
  @override
  DartUplinkPermission._fromNative(Pointer<bindings.UplinkPermission> _native)
      : super._fromNative(_native);

  bool get allowDownload => _native.ref.allow_download.convertToBool();
  bool get allowUpload => _native.ref.allow_upload.convertToBool();
  bool get allowList => _native.ref.allow_list.convertToBool();
  bool get allowDelete => _native.ref.allow_delete.convertToBool();

  /// Return null when not used, the original library returns 0;
  DateTime? get notBefore => _native.ref.not_before == 0
      ? null
      : DateTime.fromMillisecondsSinceEpoch(_native.ref.not_before * 1000);

  /// Return null when not used, the original library returns 0;
  DateTime? get notAfter => _native.ref.not_after == 0
      ? null
      : DateTime.fromMillisecondsSinceEpoch(_native.ref.not_after * 1000);

  DartUplinkPermission({
    bool allowDownload = false,
    bool allowUpload = false,
    bool allowList = false,
    bool allowDelete = false,
    DateTime? notBefore,
    DateTime? notAfter,
  }) {
    super._native = calloc.call<bindings.UplinkPermission>();
    _native.ref.allow_download = allowDownload.convertToInt();
    _native.ref.allow_upload = allowUpload.convertToInt();
    _native.ref.allow_list = allowList.convertToInt();
    _native.ref.allow_delete = allowDelete.convertToInt();
    if (notBefore != null) {
      _native.ref.not_before = notBefore.millisecondsSinceEpoch ~/ 1000;
    }
    if (notAfter != null) {
      _native.ref.not_after = notAfter.millisecondsSinceEpoch ~/ 1000;
    }
  }

  DartUplinkPermission.fullPermission() {
    super._native = calloc.call<bindings.UplinkPermission>();
    _native.ref.allow_download = true.convertToInt();
    _native.ref.allow_upload = true.convertToInt();
    _native.ref.allow_list = true.convertToInt();
    _native.ref.allow_delete = true.convertToInt();
  }

  DartUplinkPermission.readOnlyPermission() {
    super._native = calloc.call<bindings.UplinkPermission>();
    _native.ref.allow_download = true.convertToInt();
    _native.ref.allow_list = true.convertToInt();
  }

  DartUplinkPermission.writeOnlyPermission() {
    super._native = calloc.call<bindings.UplinkPermission>();
    _native.ref.allow_upload = true.convertToInt();
    _native.ref.allow_delete = true.convertToInt();
  }
}
