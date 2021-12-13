part of classes;

/// Dart wrapper for [UplinkObject].
/// This exists because it has more convenient types than the underlying
/// [UplinkObject]. This also eliminates the need to use and dereference
/// pointers from outside this library.
// TODO: rename
// TODO: preferrably we could find some way to avoid creating these dart classes for small structs
class DartUplinkObject extends StructWrapper<bindings.UplinkObject> {
  /// This should only ever be constructed from within onther classes in
  /// this library, so taking a Struct is fine.
  @override
  DartUplinkObject._fromNative(Pointer<bindings.UplinkObject> _native)
      : super._fromNative(_native);

  String get key => _native.ref.key.int8PointerToString();
  bool get isPrefix => _native.ref.is_prefix.convertToBool();
  // TODO: don't show any types from bindings publically
  bindings.UplinkSystemMetadata get system => _native.ref.system;
  bindings.UplinkCustomMetadata get custom => _native.ref.custom;
}
