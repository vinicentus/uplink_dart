part of classes;

abstract class StructWrapper<T extends Struct> {
  // This is late because we need to call a c function to get a reference in the constructor
  // Also notice that this is a pointer and as such is backed by a native C variable
  // TODO: make sure that all the pointers inside these kinds of classes are freed when not needed!
  late final Pointer<T> _native;

  /// This exist so that extending classes don't have to pass in _native in the initializer list,
  /// and can instead define [_native] in their constructor bodies.
  /// It is however slightly dangerous as it allows to construct a subclass without initializing _native...
  /// It is left up to the extenders of this class to make sure that [_native] is in fact initialized!
  StructWrapper();

  /// Simple constructor to be used when we already have a native counterpart.
  StructWrapper._fromNative(this._native);
}
