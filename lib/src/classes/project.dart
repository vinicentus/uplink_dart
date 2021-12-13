part of classes;

class DartUplinkProject extends StructWrapper<bindings.UplinkProject>
    with NativeLib {
  @override
  DartUplinkProject._fromNative(Pointer<bindings.UplinkProject> _native)
      : super._fromNative(_native);

  DartUplinkProject.openProject(DartUplinkAccess access) {
    var result = _nativeLibrary.uplink_open_project(access._native);

    throwIfError(result.error);
    _native = result.project;
  }

  abortUpload() {
    throw UnimplementedError();
  }

  beginUpload() {
    throw UnimplementedError();
  }

  close() {
    var error = _nativeLibrary.uplink_close_project(_native);
    throwIfError(error);
  }

  commitUpload() {
    throw UnimplementedError();
  }

  createBucket() {
    throw UnimplementedError();
  }

  deleteBucket() {
    throw UnimplementedError();
  }

  deleteBucketWithObjects() {
    throw UnimplementedError();
  }

  deleteObject() {
    throw UnimplementedError();
  }

  // TODO: don't depend on type from bindings (bindings.UplinkDownloadOptions)
  DartUplinkDownload downloadObject(String bucketName, String path,
      [Pointer<bindings.UplinkDownloadOptions>? downloadOptions]) {
    // If no downloadOptions are passed, we have to allocate
    // This is the same as calloc.allocate(sizeOf<UplinkDownloadOptions>());
    // downloadOptions ??= calloc.call<UplinkDownloadOptions>();
    downloadOptions ??= nullptr;

    var bucketNameInt = bucketName.stringToInt8Pointer();
    var pahtInt = path.stringToInt8Pointer();
    var result = _nativeLibrary.uplink_download_object(
        _native, bucketNameInt, pahtInt, downloadOptions);

    calloc.free(bucketNameInt);
    calloc.free(pahtInt);
    calloc.free(downloadOptions);

    throwIfError(result.error);
    return DartUplinkDownload._fromNative(result.download);
  }

  ensureBucket() {
    throw UnimplementedError();
  }

  listBuckets() {
    throw UnimplementedError();
  }

  listObjects() {
    throw UnimplementedError();
  }

  listUploadParts() {
    throw UnimplementedError();
  }

  listUploads() {
    throw UnimplementedError();
  }

  moveObject() {
    throw UnimplementedError();
  }

  revokeAccess() {
    throw UnimplementedError();
  }

  statBucket() {
    throw UnimplementedError();
  }

  statObject() {
    throw UnimplementedError();
  }

  updateObjectMetadata() {
    throw UnimplementedError();
  }

  uploadObject() {
    throw UnimplementedError();
  }

  uploadPart() {
    throw UnimplementedError();
  }
}
