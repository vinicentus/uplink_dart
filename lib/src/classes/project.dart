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

  DartUplinkObject deleteObject(String bucket, String key) {
    var bucketPointer = bucket.stringToInt8Pointer();
    var keyPointer = key.stringToInt8Pointer();

    var result =
        _nativeLibrary.uplink_delete_object(_native, bucketPointer, keyPointer);

    calloc.free(bucketPointer);
    calloc.free(keyPointer);

    throwIfError(result.error);
    return DartUplinkObject._fromNative(result.object);
  }

  DartUplinkDownload downloadObject(String bucketName, String path,
      [final DartUplinkDownloadOptions? downloadOptions]) {
    // null is allowed here, but it has to be a nullptr in C
    var nativeDownloadOptions = downloadOptions?._native ?? nullptr;

    var bucketNameInt = bucketName.stringToInt8Pointer();
    var pahtInt = path.stringToInt8Pointer();
    var result = _nativeLibrary.uplink_download_object(
        _native, bucketNameInt, pahtInt, nativeDownloadOptions);

    calloc.free(bucketNameInt);
    calloc.free(pahtInt);
    // If the user passed downloadOptions, it shuldn't be freed, because they might want to reuse it
    // If we created it, we free it.
    if (downloadOptions == null) calloc.free(nativeDownloadOptions);

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
